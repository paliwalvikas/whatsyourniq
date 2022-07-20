require 'json'

module BxBlockCatalogue
  class ProductsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    skip_before_action :validate_json_web_token, only: [:update, :index, :search, :niq_score]

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

    def niq_score
      if prod = BxBlockCatalogue::Product.find_by(id: params[:product_id])
        if prod.product_type.present? && prod.category_id.present?
          product = case_for_product(prod.product_rating, prod.product_type, prod.category_id, prod.id)
        end
      end
      if product.present?
        render json: ProductSerializer.new(product)
      else 
        render json: { errors: 'Product not found' }
      end 
    end

    def search
      product = BxBlockCatalogue::Product.where("lower(products.product_name) LIKE ? OR lower(products.bar_code) LIKE ?", "%#{params[:query].downcase}%","%#{params[:query].downcase}%")
      if product.present? 
        if params[:category_id].present?
          product = product.where(category_id: params[:category_id])
        end
        render json: ProductSerializer.new(product)
      else
        render json: {errors:'Product Not Found'}, status: :ok
      end
    end

    # def smart_searching
    #   product = BxBlockCatalogue::ProductSmartSearchService.new.health_preference(Product.last,params)
    #   if product.present?
    #     render json: ProductSerializer.new(product)
    #   else
    #     render json: { error: 'Product Not Found' }
    #   end
      # data = if params[:query] == "food_type"
      #           category = BxBlockCategories::Category.all
      #           render json: BxBlockCategories::CategorySerializer.new(category)
      #         elsif params[:query] == "category"
      #           product = category_type_product
                # render json: ProductSerializer.new(product)
              # end

    # end

    private

    def case_for_product(rating , type, category_id, id)
      case rating
      when 'A'
        a = find_product(category_id, type, ['A'],id)
      when 'B'
        a = find_product(category_id, type, ['A','B'],id)
      when 'C'
        a = find_product(category_id, type, ['A', 'B','C'],id)
      when 'D'
        a = find_product(category_id, type, ['A','B','C','D'],id)
      when 'E'
        a = find_product(category_id, type, ['A','B','C','D','E'],id)
      end
      return a
    end

    def find_product(category_id, type, rating, p_id)
      product = BxBlockCatalogue::Product.where(product_type: type, product_rating: rating, category_id: category_id).where.not(id: p_id).order(product_rating: :asc)
      product.first(5)
    end
     
    def product_param
      params.require(:data).permit(:product_name, :category_id)
    end  

    # def category_type_product
    #   category_id =  BxBlockCategories::Category.category_type(params[:category_type]).ids
    #   product =  BxBlockCatalogue::Product.where(category_id: category_id) #.pluck(:food_drink_filter).uniq
    #   # category = 
    # end
  
  end
end
