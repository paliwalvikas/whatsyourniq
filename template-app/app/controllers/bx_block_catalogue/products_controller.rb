# frozen_string_literal: true

require 'json'

module BxBlockCatalogue
  class ProductsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    skip_before_action :validate_json_web_token, only: %i[smart_search_filters product_smart_search update index search niq_score show delete_old_data delete_all_products product_calculation]

    def index
      if product = BxBlockCatalogue::Product.find_by(id: params[:id])
        product.calculation
        data = product.rda_calculation
        begin
          return render json: ProductCompareSerializer.new(product,
                                             params: { good_ingredient: data[:good_ingredient],
                                                       not_so_good_ingredient: data[:not_so_good_ingredient], user: valid_user })
        rescue AbstractController::DoubleRenderError
          return
        end
      else
        render json: { errors: 'Product not found' }
      end
    end

    def update
      product = BxBlockCatalogue::Product.find_by(id: params[:id])
      if product.calculation || product.rda_calculation
        render json: { message: 'Calculated successfully!' }
      else
        render json: { error: 'Something went wrong!' }
      end
    end

    def show
      product = BxBlockCatalogue::Product.find_by(id: params[:id])
      if product.present?
        render json: ProductSerializer.new(product)
      else
        render json: { errors: 'Product not present' }
      end
    end

    def niq_score
      products = BxBlockCatalogue::Product.all
      product = products.find_by(id: params[:product_id])
      if product.present?
        products = case_for_product(product)
        render json: ProductSerializer.new(products)
      else
        render json: { errors: 'Product not found' }
      end
    end

    def prod_health_preference
      Product.all.each do |product|
        product.product_health_preference
      end
      BxBlockCategories::FilterSubCategory.where(name: "Children's Cereals").update(name: "Children Cereals")
      render json: { errors: 'updated' }

    end

    def delete_health_preference
      BxBlockCatalogue::HealthPreference.destroy_all
      render json: { errors: 'Deleted' }
    end

    def search
      query = params[:query].split(' ')
      query_string = ""
      query.each do |data|
        query_string += "(product_name ilike '%#{data}%' OR bar_code ilike '%#{data}%')"
        query_string += " AND " unless data == query[-1]
      end
      products = Product.where(query_string)
      product = Kaminari.paginate_array(products).page(params[:page]).per(params[:per_page])
      if product.present?
        serializer = valid_user.present? ? ProductSerializer.new(product, params: {user: valid_user }) : ProductSerializer.new(product)
        begin
          return render json: {products: serializer, meta: page_meta(product)}
        rescue AbstractController::DoubleRenderError
          return
        end
      else
        render json: { errors: 'Product Not Found' }, status: :ok
      end
    end

    def delete_old_data
      Product.delete_all
      Ingredient.delete_all
      render json: { message: 'deleted successfully!' }
    end

    def smart_search_filters
      data = BxBlockCatalogue::SmartFiltersService.new.filters(params)
      render json: data
    end

    def product_smart_search
      fav_s = BxBlockCatalogue::FavouriteSearch.find_by(id: params[:fav_search_id])
      if fav_s.present?
        products = BxBlockCatalogue::SmartSearchService.new.smart_search(fav_s)&.order('product_rating ASC')
        options = serialization_options.deep_dup
        params[:per] = 15
        products_array = products.present? ? Kaminari.paginate_array(products).page(params[:page]).per(params[:per]) : []

        serializer = valid_user.present? ? ProductSerializer.new(products_array, params: {user: valid_user}) : ProductSerializer.new(products_array, options)
        begin
          return render json: {products: serializer, meta: page_meta(products_array)}
        rescue AbstractController::DoubleRenderError
          return
        end
      else
        render json: { errors: 'Product not found' }
      end
    end

    def calculation_for_rda
      if product = Product.find_by(id: params[:id])
        render json: { data: product.rda_calculation }
      else
        render json: { errors: 'Product not found' }
      end
    end

    def compare_product
      prd_ids =  current_user.compare_products.where(selected: true)
      if prd_ids.count >= 1
        data = cmp_product(prd_ids.pluck(:product_id))
        if data.present? 
          render json: {data: data} 
        else 
          render json: {message: "Product not found"}
        end
      else
        render json: {message: "Please add one more product"}
      end
    end

    def regenerate_master_data
      request = BxBlockCatalogue::MasterDataTableService.new().call
      if request.errors.messages.empty?
        render json: { message: "Success"}, status: :ok
      else
        render json: { message: request.errors.messages}, status: :unprocessable_entity
      end
    end


        
    def delete_all_products
      BxBlockCatalogue::Product.destroy_all
    end

    def product_calculation
      BxBlockCatalogue::Product.find_in_batches do |products|
        products.each do |product|
          product.calculation if product.bar_code.present?
        end
      end
    end

    private

    def case_for_product(product)
      filter_sub_category_id = product.filter_sub_category_id
      filter_category_id = product.filter_category_id
      case product.product_rating
      when 'A'
        a = find_filter_products(["A"], filter_sub_category_id, filter_category_id, product.id)
      when 'B'
        a = find_filter_products(["A"], filter_sub_category_id, filter_category_id, product.id)
      when 'C'
        a = find_filter_products(["A", "B"], filter_sub_category_id, filter_category_id, product.id)
      when 'D'
        a = find_filter_products(["A", "B" ,"C"], filter_sub_category_id, filter_category_id, product.id)
      when 'E'
        a = find_filter_products(["A", "B" ,"C", "D"], filter_sub_category_id, filter_category_id, product.id)
      end
      a
    end

    def cmp_product(ids)
      products = Product.where(id: ids)
      data = []
      products.each do |product|
        product.calculation
        p_data = product.compare_product_good_not_so_good
        data << ProductSerializer.new(product, params: {good_ingredient: p_data[:good_ingredient], not_so_good_ingredient: p_data[:not_so_good_ingredient]})
      end
      data
    end

    def find_filter_products(rating, filter_sub_category_id,filter_category_id, product_id)
      products = BxBlockCatalogue::Product.where.not(id: product_id).where(product_rating: rating, filter_sub_category_id: filter_sub_category_id, filter_category_id: filter_category_id)
      products.limit(5)
    end

    def product_param
      params.require(:data).permit(:product_name, :category_id)
    end  

    def product_found
      @product = BxBlockCatalogue::Product.find_by(id: params[:id])
    end
  end
end
