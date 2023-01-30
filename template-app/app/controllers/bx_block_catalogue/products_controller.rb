# frozen_string_literal: true

require 'json'
module BxBlockCatalogue
  class ProductsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    skip_before_action :validate_json_web_token,
                       only: %i[smart_search_filters product_smart_search update index search niq_score show delete_old_data
                                product_calculation regenerate_master_data question_listing prod_health_preference delete_health_preference change_for_cal]
    before_action :find_fav_search, only: %i[niq_score product_smart_search ofline_smart_serach]
    before_action :product_found, only: %i[niq_score index]

    def show
      product = BxBlockCatalogue::Product.find_by(id: params[:id])
      if product.present?
        CalculateProductRating.new.calculation(product)
        data = CalculateRda.new.rda_calculation(product)
        health_preference = NutritionalConsiderationService.new.check_nutrition(product, params[:fav_search_id], data) if params[:fav_search_id].present?
        begin
          render json: ProductCompareSerializer.new(product,
                                                  params: { good_ingredient: data[:good_ingredient],
                                                            not_so_good_ingredient: data[:not_so_good_ingredient], user: valid_user , health_preference: health_preference})
        rescue AbstractController::DoubleRenderError
          nil
        end
      else
        render json: { errors: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_not_found') }
      end
    end

    def index
      products = BxBlockCatalogue::Product.where(data_check: 'green')
      return unless products.present?
      products = Kaminari.paginate_array(products).page(params[:page]).per(params[:per_page])
      catalogues = ProductCompareSerializer.new(products, params: { status: 'offline' })
      render json: { products: catalogues, meta: page_meta(products) }
    end

    def update
      product = BxBlockCatalogue::Product.find_by(id: params[:id])
      if product.present? && product.data_check != 'red'
        CalculateProductRating.new.calculation(product) || CalculateRda.rda_calculation.new(product)
        render json: { message: I18n.t('controllers.bx_block_catalogue.products_controller.calculated_successfully') }
      else
        render json: { errors: I18n.t('controllers.bx_block_catalogue.products_controller.incorrect_data') }
      end
    end

    def niq_score
      products = niq_list_smart_search
      if products.present?
        products = products.order('products.product_rating ASC')
        render json: ProductSerializer.new(products)
      else
        render json: { errors: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_not_found') }
      end
    end

    def prod_health_preference
      Product.all.each do |product|
        product.product_health_preference
        CalculateRda.new.negative_and_positive(product) unless product.np_calculated?
      end
      BxBlockCategories::FilterCategory.where(name: "Malt/cereal based bev's").update(name: 'Malt/cereal based bevs')
      render json: { errors: I18n.t('controllers.bx_block_catalogue.products_controller.updated') }
    end

    def change_for_cal
      Product.update_all(np_calculated: false)
      render json: { msg: I18n.t('controllers.bx_block_catalogue.products_controller.updated') }
    end

    def delete_health_preference
      BxBlockCatalogue::HealthPreference.destroy_all
      render json: { errors: I18n.t('controllers.bx_block_catalogue.products_controller.deleted') }
    end

    def search
      query = params[:query].split(' ')
      query_string = ''
      query.each do |data|
        query_string += "(product_name ilike '%#{data}%' OR bar_code ilike '%#{data}%')"
        query_string += ' AND ' unless data == query[-1]
      end
      products = Product.where(query_string)
      products = products.where(data_check: 'green')
      products = products.where(category_id: params[:category_id]) if params[:category_id].present?
      product = Kaminari.paginate_array(products).page(params[:page]).per(params[:per_page])
      if product.present?
        serializer = if valid_user.present?
                       ProductSerializer.new(product,
                                             params: { user: valid_user })
                     else
                       ProductSerializer.new(product)
                     end
        begin
          render json: { products: serializer, meta: page_meta(product) }
        rescue AbstractController::DoubleRenderError
          nil
        end
      else
        render json: { errors: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_not_found') },
               status: :ok
      end
    end

    def delete_old_data
      Product.delete_all
      Ingredient.delete_all
      render json: { message: I18n.t('controllers.bx_block_catalogue.products_controller.deleted_successfully') }
    end

    def smart_search_filters
      data = BxBlockCatalogue::SmartFiltersService.new.filters(params)
      render json: data
    end

    def product_smart_search
      if @fav_s.present?
        products = BxBlockCatalogue::SmartSearchService.new.smart_search(@fav_s)&.order('product_rating ASC')
        options = serialization_options.deep_dup
        products_array = smart_search_result(products)
        serializer = if valid_user.present?
                       ProductSerializer.new(products_array,
                                             params: { user: valid_user })
                     else
                       ProductSerializer.new(
                         products_array, options
                       )
                     end
        begin
          data = page_meta(products_array).present? ? page_meta(products_array) : { total_count: products_array.count, product_ids: products_array&.select(:id) }
          render json: { products: serializer, favourite_search: @fav_s, meta: data }
        rescue AbstractController::DoubleRenderError
          nil
        end
      else
        render json: { errors: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_not_found') }
      end
    end

    def calculation_for_rda
      if (product = Product.find_by(id: params[:id]))
        render json: { data: CalculateRda.rda_calculation.new(product) }
      else
        render json: { errors: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_not_found') }
      end
    end

    def compare_product
      prd_ids =  current_user.compare_products.where(selected: true)
      if prd_ids.count >= 1
        data = cmp_product(prd_ids.pluck(:product_id))
        if data.present?
          render json: { data: data }
        else
          render json: { message: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_not_found') }
        end
      else
        render json: { message: I18n.t('controllers.bx_block_catalogue.products_controller.please_add_product') }
      end
    end

    def regenerate_master_data
      request = BxBlockCatalogue::MasterDataTableService.new.call
      if request.errors.messages.empty?
        render json: { message: I18n.t('controllers.bx_block_catalogue.products_controller.success') }, status: :ok
      else
        render json: { message: request.errors.messages }, status: :unprocessable_entity
      end
    end

    def product_calculation
      BxBlockCatalogue::Product.find_in_batches do |products|
        products.each do |product|
          CalculateProductRating.new.calculation(product) if product.bar_code.present?
        end
      end
      flash[:success] = I18n.t('controllers.bx_block_catalogue.products_controller.calculated_successfully')
      redirect_to '/admin'
    end

    def cmp_product(ids)
      products = Product.where(id: ids)
      data = []
      products.each do |product|
        CalculateProductRating.new.calculation(product)
        p_data = product.compare_product_good_not_so_good_ingredients
        data << ProductSerializer.new(product,
                                      params: { good_ingredient: p_data[:good_ingredient], user: current_user })
      end
      data
    end

    def requested_products
      requested_product = current_user.requested_products.new(requested_product_params)
      if requested_product.save
        BxBlockPushNotifications::PushNotificationJob.perform_now("Requested Product", "Requested Product successfully", current_user, requested_product)

        render json: RequestedProductSerializer.new(requested_product), status: :ok
        RequestedProductMailer.send_product_status(requested_product).deliver_later
      else
        render json: { error: I18n.t('controllers.bx_block_catalogue.products_controller.request_not_send') },
               status: :unprocessable_entity
      end
    end

    def requested_products_list
      render json: RequestedProductSerializer.new(current_user.requested_products.all), status: :ok
    end

    def question_listing
      render json: BxBlockCatalogue::ReportedProductQuestionSerializer.new(BxBlockCatalogue::ReportedProductQuestion.all)
    end

    def reported_product
      if check_already_reported
        reported_product = current_user.reported_products.create(reported_product_params)
        if reported_product.present?
          BxBlockPushNotifications::PushNotificationJob.perform_now("Submitted Product", "Product submitted successfully", current_user, reported_product)
          render json: BxBlockCatalogue::ReportedProductSerializer.new(reported_product)
        else
          render json: { error: I18n.t('controllers.bx_block_catalogue.products_controller.failed_to_report') },
                 status: :unprocessable_entity
        end
      else
        render json: { error: I18n.t('controllers.bx_block_catalogue.products_controller.you_already_reported') },
               status: :unprocessable_entity
      end
    end

    def reported_product_list
      render json: BxBlockCatalogue::ReportedProductSerializer.new(current_user.reported_products)
    end

    def total_product
      render json: { total_product_count: BxBlockCatalogue::Product.count }
    end

    def show_reported_product
      reported_product = current_user.reported_products.where(id: params[:id]).first
      if reported_product.present?
        render json: BxBlockCatalogue::ReportedProductSerializer.new(reported_product)
      else
        render json: { errors: 'Not Found' }, status: :unprocessable_entity
      end
    end

    def updated_reported_product
      reported_product = current_user.reported_products.where(id: params[:id]).first
      if reported_product.present?
        reported_product.update(reported_product_params)
        render json: BxBlockCatalogue::ReportedProductSerializer.new(reported_product)
      else
        render json: { error: 'Not Found' }, status: :unprocessable_entity
      end
    end

    def show_requested_product
      requested_product = current_user.requested_products.where(id: params[:id]).first
      if requested_product.present?
        render json: RequestedProductSerializer.new(requested_product), status: :ok
      else
        render json: { error: 'Not Found' }, status: :unprocessable_entity
      end
    end

    def updated_requested_product
      requested_product = current_user.requested_products.where(id: params[:id]).first
      if requested_product.present?
        requested_product.update(requested_product_params)
        render json: RequestedProductSerializer.new(requested_product), status: :ok
      else
        render json: { error: 'Not Found' }, status: :unprocessable_entity
      end
    end

    private

    def smart_search_result(products)
      if params[:page].present?
        params[:per] = 10
        products.present? ? Kaminari.paginate_array(products).page(params[:page]).per(params[:per]) : []
      else
        products
      end
    end

    def niq_list_smart_search
      if params[:fav_search_id].present? && params[:product_id].present? && @product.present?
        data = BxBlockCatalogue::SmartSearchService.new.smart_search(@fav_s)&.order('product_rating ASC')
        products = smart_search_result(data)
        products&.where&.not(id: params[:product_id])&.limit(20)
      elsif params[:product_id].present? && @product.present?
        case_for_product(@product) if @product.present?
      end
    end

    def find_fav_search
      @fav_s = BxBlockCatalogue::FavouriteSearch.find_by(id: params[:fav_search_id])
    end

    def case_for_product(product)
      filter_sub_category_id = product.filter_sub_category_id
      filter_category_id = product.filter_category_id
      case product.product_rating
      when 'A'
        find_filter_products(['A'], filter_sub_category_id, filter_category_id, product.id)
      when 'B'
        find_filter_products(['A'], filter_sub_category_id, filter_category_id, product.id)
      when 'C'
        find_filter_products(%w[A B], filter_sub_category_id, filter_category_id, product.id)
      when 'D'
        find_filter_products(%w[A B C], filter_sub_category_id, filter_category_id, product.id)
      when 'E'
        find_filter_products(%w[A B C], filter_sub_category_id, filter_category_id, product.id)
      end
    end

    def find_filter_products(rating, filter_sub_category_id, filter_category_id, product_id)
      products = BxBlockCatalogue::Product.where.not(id: product_id).where(product_rating: rating,
                                                                           filter_sub_category_id: filter_sub_category_id, filter_category_id: filter_category_id)
      products.limit(20)
    end

    def product_param
      params.require(:data).permit(:product_name, :category_id)
    end

    def product_found
      @product = BxBlockCatalogue::Product.find_by(id: params[:id] || params[:product_id])
    end

    def requested_product_params
      params.permit(:id, :name, :refernce_url, :weight, :status, :category_id, barcode_image: [], product_image: [])
    end

    def reported_product_params
      params.permit(:id, :description, :product_id, ans_ids: [])
    end

    def check_already_reported
      if current_user.reported_products.where(product_id: params[:product_id],
                                              account_id: current_user.id).present?
        false
      else
        true
      end
    end
  end
end
