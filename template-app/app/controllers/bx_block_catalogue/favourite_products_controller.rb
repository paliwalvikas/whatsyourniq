module BxBlockCatalogue
  class FavouriteProductsController < ApplicationController
    before_action :find_fav_prod, only: [:update]
    before_action :find_product, only: [:destroy]

    def index
      fav_prod = current_user.favourite_products.all
      if fav_prod.present?
        render json: FavouriteProductSerializer.new(fav_prod), status: :ok
      else
        render json:  { message: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_not_found') },
               status: :unprocessable_entity
      end
    end

    def create
      fav_prod = current_user.favourite_products.new(fav_prod_params)
      if fav_prod.save
        render json: FavouriteProductSerializer.new(fav_prod)
                    .serializable_hash,
                    status: :created
      else
        render json: ErrorSerializer.new(fav_prod).serializable_hash,
        status: :unprocessable_entity
      end
    end

    def update
      if @fav_prod.present? && @fav_prod.update(favourite: params[:favourite])
        render json: FavouriteProductSerializer.new(@fav_prod)
                         .serializable_hash,
               status: :ok
      else
        render json:  { message: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_not_found') },
               status: :unprocessable_entity
      end
    end

    def filter_fav_product
      p_ids = current_user&.favourite_products.select(:product_id)
      if params[:product_rating].present? && p_ids.present?
        products = BxBlockCatalogue::Product.where(id: p_ids, product_rating: params[:product_rating])
        fav_prod = current_user&.favourite_products&.where(product_id: products.ids)&.joins(:product).order("products.product_rating asc")
        render json: FavouriteProductSerializer.new(fav_prod).serializable_hash,
               status: :ok
      else
        render json:  { message: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_not_found') },
               status: :unprocessable_entity
      end
    end

    def fav_search
      query = search_query
      prd_id = current_user&.favourite_products&.select(:product_id)
      products = BxBlockCatalogue::Product.where(id: prd_id)&.where(query)
      if products.present? 
        return render json: FavouriteProductSerializer.new(FavouriteProduct.where(product_id: products&.ids), params: {user: current_user})
      else
        render json: { errors: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_not_found') }, status: :ok
      end
    end

    def destroy
      if @fav_prod.present? && @fav_prod.destroy
        render json: { success: true, message: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_successfully_deleted') }, status: :ok
      else
        render json:  { message: I18n.t('controllers.bx_block_catalogue.favourite_products_controller.product_not_found') },
               status: :unprocessable_entity
      end
    end

    private

    def search_query
      query = params[:query].split(' ')
      query_string = ""
      query.each do |data|
        query_string += "(product_name ilike '%#{data}%' OR bar_code ilike '%#{data}%')"
        query_string += " AND " unless data == query[-1]
      end
      query_string
    end

    def fav_prod_params
      params.require(:data).require(:attributes).permit(:account_id, :product_id, :favourite)
    end

    def find_product
      @fav_prod = current_user.favourite_products.find_by(product_id: params[:product_id] || params[:id])
    end

    def find_fav_prod
      @fav_prod = current_user.favourite_products.find_by_id(params[:id])
    end
  end
end
