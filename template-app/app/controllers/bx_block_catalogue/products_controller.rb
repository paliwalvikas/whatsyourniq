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

    def show
      product = BxBlockCatalogue::Product.find_by(id: params[:id])
      if product.present?
        render json: ProductSerializer.new(product)
      else  
        render json: { errors: 'Product not present' } 
      end   
    end   

    private 
    def product_param
      params.require(:data).permit(:product_name)
    end  
  end
end
