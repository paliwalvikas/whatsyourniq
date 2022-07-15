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
    #   if product.present?
    #     render json: ProductSerializer.new(product)
    #   else
    #     render json: { error: 'Product Not Found' }
    #   end
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

    # def filter_product
    #   product = BxBlockCatalogue::Product.all
    #   # "pakaged_food", "row_food", "cooked_food"
    #   product = product.where(product_type: params[:food_type]) if params[:food_type].present?
    #   product = category_filter(product)
    #   product = product.where(product_rating: params[:niq_score]) if params[:niq_score].present?
    #   a = food_allergies(product) 
    # end
    #   # product = product.where(category_id: params[:category_id]) if params[:category].present?
    #   # product = product.where(category_filter: params[:category][:category_filter])
    #   # #foof preferance #no artificial colors (not present)
    # def food_preferance
    #   ingredients = BxBlockCatalogue::Ingredient.all
    #   ingredients = ingredients.where(veg_and_nonveg: params[:veg_and_nonveg]) if params[:veg_and_nonveg].present?
    #   ingredients = ingredients.where(gluteen_free: params[:gluteen_free]) if params[:gluteen_free].present?
    #   ingredients = ingredients.where(added_sugar: params[:no_added_sugar]) if params[:no_added_sugar].present?
    #   ingredients = ingredients.where(artificial_preservative: params[:artificial_preservative]) if params[:artificial_preservative].present?
    #   ingredients = ingredients.where(organic: params[:organic]) if params[:organic].present?
    #   ingredients = ingredients.where(vegan_product: params[:vegan_product]) if params[:vegan_product].present? 
    # end

    # def food_allergies(product)
    #   # food allergiess filter
    #   allergies = eval(params[:allergies])
    #   ingredients = BxBlockCatalogue::Ingredient.all
    #   ingredients = ingredients.where('egg ILIKE ?', 'yes') if check('egg', ingredients, allergies)
    #   ingredients = ingredients.where('fish ILIKE ?', 'yes') if check('fish', ingredients, allergies)
    #   ingredients = ingredients.where('shellfish ILIKE ?', 'yes') if check('shellfish',ingredients,allergies)
    #   ingredients = ingredients.where('tree_nuts ILIKE ?', 'yes') if check('tree_nuts',ingredients,allergies)
    #   ingredients = ingredients.where('peanuts ILIKE ?', 'yes') if check('peanuts', ingredients, allergies)
    #   ingredients = ingredients.where('wheat ILIKE ?', 'yes') if check('wheat', ingredients, allergies)
    #   ingredients = ingredients.where('soyabean ILIKE ?', 'yes') if check('soyabean', ingredients, allergies)
    #   p_id = ingredients.pluck(:product_id) if ingredients.present?
    #   product.where(id: p_id) if p_id.present?
    # end

    # def category_filter(product)
    #   product = category_searching(product, 'Packaged_Food', params[:category]['packaged_food']) if params[:category]['packaged_food'].present? && product.present?
    #   product = category_searching(product, 'raw_food', params[:category]['raw_food']) if params[:category]['raw_food'].present? && product.present?
    #   product = category_searching(product, 'packaged_drink', params[:category]['packaged_drink']) if params[:category]['packaged_drink'].present? && product.present?
    #   product = category_searching(product, 'packaged_cheese_oil', params[:category]['packaged_cheese_oil']) if params[:category]['packaged_cheese_oil'].present? && product.present?
    #   product = category_searching(product, 'cooked_food', params[:category]['cooked_food']) if params[:category]['cooked_food'].present? && product.present?
    #   product
    # end

    # def category_searching(product, cat_name, category_filter)
    #   cat_id = BxBlockCategories::Category.find_by(category_type: cat_name) 
    #   product = product.where(category_id: cat_id).where(category_filter: category_filter)
    # end

    # def check(value, ingredients,allergies)
    #   allergies.include?(value) && ingredients.present?
    # end

    def product_param
      params.require(:data).permit(:product_name, :category_id)
    end  

  end
end
