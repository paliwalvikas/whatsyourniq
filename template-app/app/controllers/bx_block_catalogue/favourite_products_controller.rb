module BxBlockCatalogue
  class FavouriteProductsController < ApplicationController
    before_action :find_fav_prod, only: [:update, :destroy]

    def index
      fav_prod = current_user.favourite_products.all
      if fav_prod.present?
        render json: FavouriteProductSerializer.new(fav_prod), status: :ok
      else
        render json:  { message: "Product not found" },
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
        render json:  { message: "Product not found" },
               status: :unprocessable_entity
      end
    end

    def filter_fav_product
      p_ids = current_user&.favourite_products.select(:product_id)
      if params[:product_rating].present? && p_ids.present?
        products = BxBlockCatalogue::Product.where(id: p_ids, product_rating: params[:product_rating])
        fav_prod = current_user&.favourite_products&.where(product_id: products.ids)
        render json: FavouriteProductSerializer.new(fav_prod).serializable_hash,
               status: :ok
      else
        render json:  { message: "Product not found" },
               status: :unprocessable_entity
      end
    end

    def destroy
      if @fav_prod.present? && @fav_prod.destroy
        render json: { success: true, message: "Product successfully deleted" }, status: :ok
      else
        render json:  { message: "Product not found" },
               status: :unprocessable_entity
      end
    end

    private

    def fav_prod_params
      params.require(:data).require(:attributes).permit(:account_id, :product_id, :favourite)
    end

    def find_fav_prod
      @fav_prod = current_user.favourite_products.find_by_id(params[:id])
    end
  end
end