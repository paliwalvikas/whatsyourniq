module BxBlockCatalogue
  class CompareProductsController < ApplicationController
    before_action :load_product, only: [:update, :destroy]

    def index
      serializer = CompareProductSerializer.new(current_user.compare_products.where(selected: true))

      render json: serializer, status: :ok
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
      @product = current_user.compare_products.find_by(id: params[:id])

      if @product.nil?
        render json: {
            message: "Compare product with id #{params[:id]} doesn't exists"
        }, status: :not_found
      end
    end

  end
end
