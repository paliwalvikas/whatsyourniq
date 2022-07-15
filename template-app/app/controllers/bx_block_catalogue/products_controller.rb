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

    def niq_score
      if prod = BxBlockCatalogue::Product.find_by(id: params[:product_id])
        if prod.product_type.present? && prod.category_id.present?
          product = case_for_product(prod.product_rating, prod.product_type, prod.category_id)
        end
      end
      if product.present?
        render json: ProductSerializer.new(product)
      else 
        render json: { errors: 'Product not found' }
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

    # def smart_searching
    #   product = filter_product
    #   render json: ProductSerializer.new(product)
    # end

    private

    def case_for_product(rating , type, category_id)
      case rating
      when 'A'
        a = find_product(category_id, type, ['A'])
      when 'B'
        a = find_product(category_id, type, ['A','B'])
      when 'C'
        a = find_product(category_id, type, ['A', 'B','C'])
      when 'D'
        a = find_product(category_id, type, ['A','B','C','D'])
      when 'E'
        a = find_product(category_id, type, ['A','B','C','D','E'])
      end
      return a
    end

    def find_product(category_id, type, rating)
      product = BxBlockCatalogue::Product.where(product_type: type, product_rating: rating, category_id: category_id).order(product_rating: :asc)
      product.first(5)
    end

    # def filter_product(value )
    #   # "pakaged_food", "row_food", "cooked_food"
    #     product = BxBlockCatalogue::Product.where(product_type: params[:food_type]) if params[:food_type].present?
    #     product = BxBlockCatalogue::Product.where(category_id: params[:category_id]) if params[:category].present?
          
      
    #   when "packaged_drinks"
    #     case params[:category][:packaged_drinks]
    #     when "cofee_tea_and_breavrages"
    #     end
    #   when "packaged_chiz_and_oil"
    #     case params[:category][:packaged_chiz_and_oil]
    #     when "cooking_and_baking_supplies"
    #     end
    #   when "raw_food"
    #     case params[:category][:raw_food]
    #     when "pulses"
    #     when "green_leafy_vegetables"
    #     end
    #   when "cooked_food"
    #     case params[:category][:cooked_food]          
    #     when "NA"
    #     end
    #   when params[:sub_category]
    #     BxBlockCategories::SubCategory.find_by(params[:sub_category_id])
    #   when params[:niq_score]
    #     BxBlockCatalogue::Product.where( product_rating: params[:product_rating])
    #   when params[:food_allergies]

    #   when params[:food_preferance]

    #   when params[:functional_preferance]
    #     BxBlockCatalogue::Product.second.ingredient
    #   when params[:health_preferance]
    #   end
        
    # end

    def product_param
      params.require(:data).permit(:product_name, :category_id)
    end  

  end
end
