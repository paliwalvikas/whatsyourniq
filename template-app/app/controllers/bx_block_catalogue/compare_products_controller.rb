module BxBlockCatalogue
  class CompareProductsController < ApplicationController
    before_action :load_product, only: [:update]

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
      update_result = @product.update(compare_params)
      if update_result
        render json: CompareProductSerializer.new(@product)
                         .serializable_hash,
               status: :created
      else
        render json: ErrorSerializer.new(@product).serializable_hash,
               status: :unprocessable_entity
      end

    end

    def index
      serializer = CompareProductSerializer.new(current_user.compare_products.all)

      render json: serializer, status: :ok
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
