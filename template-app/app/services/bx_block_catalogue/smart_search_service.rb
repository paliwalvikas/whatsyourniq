module BxBlockCatalogue
  class SmartSearchService

  	def smart_search(params)
      product = BxBlockCatalogue::Product.all
      # "pakaged_food", "row_food", "cooked_food"
      product = food_type(params, product)if check?(params[:food_type]) && check?(product)
      product = product.product_rating(params[:niq_score]) if check?(params[:niq_score]) && check?(product)
      product = s_food_allergies(product, params) if check?(params[:food_allergies]) && check?(product)
      product = food_preferance(params, product) if check?(params[:food_preference]) && check?(product)
      product = p_health_preference(params, product) if check?(params[:health_preference]) && check?(product)
	    product = p_category_filter(params, product) if check?(params[:product_category]) && check?(product)
    end

	  private

    def food_type(params, product)
      cat_ids= BxBlockCategories::Category.where(category_type: params[:food_type]).pluck(:id)
      product.where(category_id: cat_ids)
    end

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
        val = f_all == 'artificial_preservative'|| f_all == 'added_sugar' || f_all == 'no_artificial_color' || f_all == 'nonveg' ? 'no' : 'yes'
        ingredients = allergies(f_all.downcase, ingredients, val)
      end
     ingredient_to_product(ingredients, product)
    end

    def p_health_preference(params, product)
      BxBlockCatalogue::ProductHealthPreferenceService.new.health_pref_search(product, params[:health_preference])
    end

    def check?(val)
      val.present?
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
      val = val == 'veg' || val == 'nonveg' ? 'veg_and_nonveg' : val
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