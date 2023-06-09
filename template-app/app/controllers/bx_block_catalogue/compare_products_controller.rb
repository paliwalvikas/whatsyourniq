module BxBlockCatalogue
  class CompareProductsController < ApplicationController
    before_action :load_product, only: [:update, :destroy]
    skip_before_action :verify_authenticity_token, only: [:destroy_all]

    def index
      list_of_product = current_user.compare_products.where(selected: true)
      if list_of_product.present?
        render json: CompareProductSerializer.new(list_of_product)
      else
        render json: {error: I18n.t('controllers.bx_block_catalogue.compare_products_controller.no_product_found')}, status: :unprocessable_entity
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

    def destroy_all
      compare_products = BxBlockCatalogue::CompareProduct.destroy_all
      render json: { message: I18n.t('controllers.bx_block_catalogue.compare_products_controller.record_deleted'), product: compare_products }
    end

    private

    def compare_params
      params.permit(:account_id, :product_id, :selected)
    end

    def load_product
      @product = current_user.compare_products.find_by(product_id: params[:id])

      if @product.nil?
        render json: {
            message: I18n.t('controllers.bx_block_catalogue.compare_products_controller.compare_product_not_exists')
        }, status: :not_found
      end
    end

  end
end
