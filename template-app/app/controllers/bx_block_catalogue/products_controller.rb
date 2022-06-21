require 'json'

module BxBlockCatalogue
  class ProductsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    skip_before_action :validate_json_web_token, only: [:update, :index]

    def index
      if product = BxBlockCatalogue::Product.find_by(product_name: params[:product_name])
        product.calculation
        product.product_sodium_level
        product.vit_min_value
        product.protein_value
        product.dietary_fibre
        product.calories_energy
        render json: ProductSerializer.new(product)
      else 
        render json: { errors: 'Product not found' }
      end     
    end

    def update
      product = BxBlockCatalogue::Product.find_by(id: params[:id])
      if product.calculation
        render json: {message: 'Calculated successfully!'}
      else
        render json: { error: 'Something went wrong!' }
      end
    end

    def search
      search = "%#{params[:query]}%"
      product = BxBlockCatalogue::Product.where('product_name ILIKE ?', search)
      if product.present? && params[:category_id].present?
        product = product.where(category_id: params[:category_id])
        render json: ProductSerializer.new(product)
      else
        render json: {errors:'Product Not Found'}, status: :ok
      end
    end

    private 
    def product_param
      params.require(:data).permit(:product_name, :category_id)
    end  
  end
end
