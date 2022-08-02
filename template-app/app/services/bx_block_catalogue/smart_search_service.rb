module BxBlockCatalogue
  class SmartSearchService

  	def smart_search(params)
      product = BxBlockCatalogue::Product.all
      # "pakaged_food", "row_food", "cooked_food"
      product = product.where(category_id: params[:category_id]) if params[:category_id].present?
      product = product.product_rating(params[:niq_score]) if params[:niq_score].present?
      product = s_food_allergies(product, params) if params[:food_allergies].present?
      product = food_preferance(params, product) if params[:food_preference].present?
      product = p_health_preference(params, product) if params[:health_preference].present?
	  end

	  private

    # food allergiess filter
    def s_food_allergies(product, params)
      ingredients = BxBlockCatalogue::Ingredient.where(product_id: product.ids)
        params[:food_allergies].each do |f_all|
          ingredients = allergies(f_all.downcase, ingredients, 'no')
        end
      ingredient_to_product(ingredients, product)
    end

    def food_preferance(params, product)
      ingredients = BxBlockCatalogue::Ingredient.where(product_id: product.ids)
      params[:food_preference].each do |f_all|
        val = f_all == 'artificial_preservative'|| f_all == 'added_sugar' || f_all == 'no_artificial_color' ? 'no' : 'yes'
        f_all = f_all == 'veg' || f_all == 'nonveg' ? 'veg_and_nonveg' : f_all 
        ingredients = allergies(f_all.downcase, ingredients, val)
      end
     ingredient_to_product(ingredients, product)
    end

    # def p_category_filter(product, params)
    # 	#category filter 
    #   product = category_searching(product, 'Packaged_Food', params[:category]['packaged_food']) if params[:category]['packaged_food'].present? && product.present?
    #   product = category_searching(product, 'raw_food', params[:category]['raw_food']) if params[:category]['raw_food'].present? && product.present?
    #   product = category_searching(product, 'packaged_drink', params[:category]['packaged_drink']) if params[:category]['packaged_drink'].present? && product.present?
    #   product = category_searching(product, 'packaged_cheese_oil', params[:category]['packaged_cheese_oil']) if params[:category]['packaged_cheese_oil'].present? && product.present?
    #   product = category_searching(product, 'cooked_food', params[:category]['cooked_food']) if params[:category]['cooked_food'].present? && product.present?
    #   product
    # end

    def ingredient_to_product(ingredients, product)
      p_id = ingredients.pluck(:product_id) if ingredients.present?
      product.where(id: p_id) if p_id.present?
    end

    def allergies(val, ingredients, col)
      ingredients.where("#{val} ILIKE ?", col) 
    end

    def category_searching(product, cat_name, category_filter)
      cat_id = BxBlockCategories::Category.find_by(category_type: cat_name) 
      product = product.where(category_id: cat_id).where(category_filter: category_filter)
    end

    def check(value, ingredients,allergies)
      allergies.include?(value) && ingredients.present?
    end
  end
end