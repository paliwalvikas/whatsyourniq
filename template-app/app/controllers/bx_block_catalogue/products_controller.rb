require 'json'

module BxBlockCatalogue
  class ProductsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token, except: [:create, :index]

    def index
      product = BxBlockCatalogue::Product.where("lower(product_name) = ?", params[:product_name].downcase).first
      product.calculation
      render json: ProductSerializer.new(product)
    end

    private 

    def product_param
      params.require(:data).permit(:product_name)
    end  
  end
end