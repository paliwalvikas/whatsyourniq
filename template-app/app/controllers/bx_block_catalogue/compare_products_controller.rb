module BxBlockCatalogue
  class CompareProductsController < ApplicationController
    before_action :load_product, only: [:update, :destroy]

    def index
      list_of_product = current_user.compare_products.where(selected: true)
      if list_of_product.present?
        render json: CompareProductSerializer.new(list_of_product)
      else
        render json: {error: "No product found"}, status: :unprocessable_entity
      end
    end

    def create
      product = current_user.compare_products.new(compare_params.merge(selected: true))
      save_result = product.save

      if save_result
        render json: CompareProductSerializer.new(product)
                         .serializable_hash,
               status: :created
      else
        render json: ErrorSerializer.new(product).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def update
      @product.update(compare_params)
      update_result = @product.save(validate: false)
      if update_result
        render json: CompareProductSerializer.new(@product)
                         .serializable_hash,
               status: :created
      else
        render json: ErrorSerializer.new(@product).serializable_hash,
               status: :unprocessable_entity
      end
    end


    def destroy
      return if @product.nil?

      if @product.destroy
        render json: { success: true }, status: :ok
      else
        render json: ErrorSerializer.new(@product).serializable_hash,
               status: :unprocessable_entity
      end
    end

    private

    def compare_params
      params.permit(:account_id, :product_id, :selected)
    end

    def load_product
      @product = current_user.compare_products.find_by(product_id: params[:id])

      if @product.nil?
        render json: {
            message: "Compare product with id #{params[:id]} doesn't exists"
        }, status: :not_found
      end
    end

  end
end
