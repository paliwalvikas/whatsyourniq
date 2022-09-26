module BxBlockCatalogue
  class SmartSearchService

  	def smart_search(params)
      product = BxBlockCatalogue::Product.all
      # "pakaged_food", "row_food", "cooked_food"
      product = food_type(params, product) if check?(params[:food_type]) && check?(product)
	    product = p_category_filter(product, params) if check?(params[:product_category]) && check?(product)
      product = p_sub_category(product, params) if check?(params[:product_sub_category]) && check?(product)
      product = product.product_rating(params[:niq_score]) if check?(params[:niq_score]) && check?(product)
      product = s_food_allergies(product, params) if check?(params[:food_allergies]) && check?(product)
      product = food_preferance(params, product) if check?(params[:food_preference]) && check?(product)
      product = functional_preference(product, params) if check?(params[:functional_preference]) && check?(product)
      product = p_health_preference(params, product) if check?(params[:health_preference]) && check?(product)
      params.update(product_count: product.count) if product.present?
      product if product.present?
    end

    def p_health_preference(params, product)
      val = params[:health_preference] 
      return product.where(id: 0) if val.include?('\\') 
      val = val.include?(' ') ? val.downcase.tr!(" ", "_") : val.downcase
      hp_ids = BxBlockCatalogue::HealthPreference.where("#{val} = ?", true).map(&:product_id)
      hp_ids.present? ? product.where(id: hp_ids) : product.where(id: 0)
    end

	  private

    def functional_preference(product, f_p)
      fun = eval(f_p[:functional_preference])
      pr_ids =[]
      positive = product.select(:id, :positive_good)
      negative = product.select(:id, :negative_not_good)
      fun.each do |key, value|
        key = key.to_s.include?(' ') ? key.to_s.downcase.tr!(" ", "_") : key.to_s.downcase
        products = prd_negative_not_good.include?(key.to_s) ? negative : positive 
        products = positive_negative(products, key.downcase, value)
        pr_ids << products.pluck(:id) if products.present?
      end
      product.present? ? product.where(id: pr_ids.flatten.uniq) : nil
    end

    def positive_negative(product, key, value)
      p_ids =[]
      product.each do |prd|
        data = prd_negative_not_good.include?(key) ?  prd.negative_not_good : prd.positive_good
        data = data.map{|i| eval(i)}
        data.map{|dt| p_ids << prd.id if dt[:name].to_s == key && value.include?(dt[:level])}
      end
      product.where(id: p_ids.compact) if p_ids.present? && product.present?
    end

    def prd_negative_not_good
      ['calories', 'fat', 'saturated_fat','cholesterol','trans_fat','sodium','Total sugar']
    end

    def food_type(params, product)
      cat_ids = BxBlockCategories::Category.where(category_type: params[:food_type].map{|i| i.downcase.tr!(" ", "_")}).pluck(:id)
      product.where(category_id: cat_ids)
    end

    def s_food_allergies(product, params)
      ingredients = BxBlockCatalogue::Ingredient.where(product_id: product.ids)
      ids = []
        params[:food_allergies].each do |f_all|
          f_all = f_all.include?(' ') ? f_all.downcase.tr!(" ", "_") : f_all.downcase
          ing = allergies(f_all, ingredients, 'yes')
          ids << ing.pluck(:product_id) if ing.present?
        end
      product.where.not(id: ids.flatten.compact.uniq) if ids.flatten.present?
      # ingredient_to_product(ingredients, product)
    end

    def food_preferance(params, product)
      ingredients = BxBlockCatalogue::Ingredient.where(product_id: product.ids)
      ids = []
      params[:food_preference].each do |f_all|
        f_all = f_all.include?(' ') ? f_all.downcase.tr!(" ", "_") : f_all.downcase
        val = f_all == 'no_artificial_preservative'|| f_all == 'no_added_sugar' || f_all == 'no_artificial_color' || f_all == 'nonveg' ? 'no' : 'yes'
        f_all = 'added_sugar' if f_all == 'no_added_sugar'
        f_all = 'artificial_preservative' if f_all == 'no_artificial_preservative'
        f_all = 'gluteen_free' if f_all == 'gluten_free' 
        ingredients = allergies(f_all.downcase, ingredients, val)
      end
      product.where(id: ingredients.pluck(:product_id)) if ingredients.present?
    end

    def p_sub_category(product, params)
      psc = eval(params[:product_sub_category])
      prd = []
      psc.keys.each do |f_d|
        fc = BxBlockCategories::FilterCategory.where(name: psc[f_d].keys).ids
        fsc = BxBlockCategories::FilterSubCategory.where(name: psc[f_d].values.flatten).ids
        val = f_d.to_s.downcase
        val.slice!('packaged ')
        prd << product.where(food_drink_filter: val, filter_category_id: fc, filter_sub_category_id: fsc).ids 
      end
      product.where(id: prd.flatten.compact)
    end

    def p_category_filter(product, params)
      cao = eval(params[:product_category]) 
      p_ids = []
      p_ids << cheese_and_oil(product, cao[:"Packaged Cheese And Oil"]).pluck(:id) if check?(cao[:"Packaged Cheese And Oil"]) && check?(product)
      p_ids << food_drink_filter(product, cao) if (check?(cao[:"Packaged Food"]) || check?(cao[:"Packaged Drink"])) && check?(product)
      p_ids << raw_and_cooked(product, cao).pluck(:id) if (check?(cao[:raw_food]) || check?([:cooked_food])) && check?(product)
      product.where(id: p_ids.flatten.compact.uniq) if check?(p_ids)
    end

    def raw_and_cooked(product, cao)
      f_c_ids =[]
      cat_ids = BxBlockCategories::Category.where.not(category_type: 'packaged_food').pluck(:id)
      f_c_ids << BxBlockCategories::FilterCategory.where(name: cao[:cooked_food]).pluck(:id) if check?(cao[:cooked_food])
      f_c_ids << BxBlockCategories::FilterCategory.where(name: cao[:raw_food]).pluck(:id) if check?(cao[:raw_food])
      check?(f_c_ids.flatten) ? product.where(category_id: cat_ids, filter_category_id: f_c_ids.flatten.compact.uniq) : product.where(id: 0)
    end

    def food_drink_filter(product, cao)
      food_ids , drink_ids = [], []
      food_ids << BxBlockCategories::FilterCategory.where(name: cao[:"Packaged Food"]).pluck(:id) if check?(cao[:"Packaged Food"])
      drink_ids << BxBlockCategories::FilterCategory.where(name: cao[:"Packaged Drink"]).pluck(:id) if check?(cao[:"Packaged Drink"])
      if cao[:"Packaged Food"].present? && cao[:"Packaged Drink"].present?
        f_product, d_product = [], []
        f_product = product.food.where(filter_category_id: food_ids.flatten.compact.uniq).ids if check?(food_ids.flatten)
        d_product = product.drink.where(filter_category_id: drink_ids.flatten.compact.uniq).ids if check?(drink_ids.flatten)
        ids = f_product + d_product
        product = ids.flatten.uniq
      elsif cao[:"Packaged Drink"].present?
        product = product.drink.where(filter_category_id: drink_ids.flatten.compact.uniq).ids 
      elsif cao[:"Packaged Food"].present?
        product = product.food.where(filter_category_id: food_ids.flatten.compact.uniq).ids
      end
      check?(product) ? product : product.where(id: 0)
    end

    def cheese_and_oil(product, cao)
      f_cat_ids = BxBlockCategories::FilterCategory.where(name: cao).pluck(:id)
      prod = product.where(product_type: 'cheese_and_oil', filter_category_id: f_cat_ids)
    end

    def ingredient_to_product(ingredients, product)
      p_id = ingredients.pluck(:product_id) if ingredients.present?
      product.where(id: p_id) if p_id.present?
    end

    def allergies(val, ingredients, col)
      col = if val == 'veg' 
              'veg'
            elsif val == 'nonveg'
              'nonveg'
            else
              col
            end
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

    def check?(val)
      val.present?
    end
  
  end
end