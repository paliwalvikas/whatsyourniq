require 'json'

module BxBlockCatalogue
  class ProductsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    skip_before_action :validate_json_web_token, only: [:update, :index]

    # def index
    #   if product = BxBlockCatalogue::Product.where("lower(product_name) = ?", params[:product_name].downcase).first
    #     product.calculation
    #     render json: ProductSerializer.new(product)
    #   else 
    #     render json: { errors: 'Product not found' }
    #   end     
    # end

    def update
      product = BxBlockCatalogue::Product.find_by(id: params[:id])
      if product.calculation
        render json: {message: 'Calculated successfully!'}
      else
        render json: { error: 'Something went wrong!' }
      end
    end

    private 
    def product_param
      params.require(:data).permit(:product_name)
    end  
  end
end
