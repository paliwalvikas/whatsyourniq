require 'json'

module BxBlockCatalogue
  class ProductsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    skip_before_action :validate_json_web_token, only: [:update, :index, :search]

    def index
      if product = BxBlockCatalogue::Product.find_by(id: params[:id])
        product.calculation
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

    def search
      search = "%#{params[:query]}%"
      product = BxBlockCatalogue::Product.where('product_name ILIKE ?', search)
      if product.present? 
        if params[:category_id].present?
          product = product.where(category_id: params[:category_id])
        end
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
