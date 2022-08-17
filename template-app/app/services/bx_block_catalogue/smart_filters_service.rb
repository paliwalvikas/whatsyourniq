module BxBlockCatalogue
  class SmartFiltersService

  	def filters(params)
  		data = []
  		data = case params[:query]
  		when  "food_type"
        food_type(data)
      when "category"
        category(params, data)
      when "sub_category"
      	sub_category(params, data)
      when "niq_score"
      	niq_score(data)
      when "food_allergies"
      	food_allergies(data)
      when "food_preference"
        food_preference(data) 
      when "functional_preference"
        functional_preference(data)      
      when "health_preference"
        health_preference(data) 
      end
      # data
  	end

  	private

    def food_type(data)
			category = BxBlockCategories::Category.all
      category.each do |category|
        product = BxBlockCatalogue::Product.where(category_id: category.id)
        data << {count: product.count, food_type: category.category_type.titleize}
      end
      data = {count: total_count(data), food_type: data}
    end

  	def category(params, data)
      product = find_product(params)
    	product.each do |prd|
  			filter = []
    		prod =  BxBlockCatalogue::Product.where(food_drink_filter: prd)
    		uniq_p = prod.map{|p| p.filter_category}.uniq
    		uniq_p.map{ |i| filter << {count: prod.where(filter_category_id: i.id).count, category_filter: i.name } }
      	data << {count: total_count(filter), category: ("packaged " + prd).titleize, category_filter: filter }
			end
      c_ao = BxBlockCatalogue::Product.where(product_type: "cheese_and_oil")
      c_prod = c_ao.map{|p| p.filter_category}.uniq
      cao_filter = []
      c_prod.each do |cao|
        cao_filter << {count: c_ao.where(filter_category_id: cao.id).count, category_filter: cao.name }
      end
      data << {count:  total_count(cao_filter), category: 'packaged_cheese_and_oil'.titleize, category_filter: cao_filter }

      cat= BxBlockCategories::Category.where.not(category_type: 'packaged_food')
      cat.each do |c|
        filter = []
        prod = BxBlockCatalogue::Product.where(category_id: c.id)
        u_f = prod.map{|i| i.filter_category}.uniq
        u_f.map{ |i| filter << {count: prod.where(filter_category_id: i.id).count, category_filter: i.name } }
        data << {count: total_count(filter), category: c.category_type.titleize, category_filter: filter}
      end
			data = {count: total_count(data), category: data}
    end

    def sub_category(params, data)
      product = find_product(params)
      product.each do |prd|
        filter = []
        prod =  BxBlockCatalogue::Product.where(food_drink_filter: prd)
        cat_filter = prod.map{|p| p.filter_category}.uniq
        cat_filter.each do |cat_f|
          sub_filter =[]
          uniq_sub = prod.where(filter_category_id: cat_f.id).map{|p| p.filter_sub_category}.uniq
          uniq_sub.each do |sub_c|
            sub_filter << {count: prod.where(filter_sub_category_id: sub_c.id).count, sub_category_filter: sub_c.name } 
          end
          filter << {count: total_count(sub_filter), category: cat_f.name , sub_category_filter: sub_filter } 
        end
        data << {count: total_count(filter), food_drink_filter: ("packaged " + prd).titleize, category_filter: filter }
      end
      data = {count: total_count(data), sub_category: data}
    end
  	
  	def find_product(params)
      product =  BxBlockCatalogue::Product.all.pluck(:food_drink_filter).uniq
  	end

  	def niq_score(data)
  		rating = BxBlockCatalogue::Product.all.order(product_rating: :asc).pluck(:product_rating).uniq.compact.delete_if(&:blank?)
  		rating.each do |rat|
  			data << {count: BxBlockCatalogue::Product.where(product_rating: rat).count, product_rating: rat }
  		end
  		data = {count: total_count(data), niq_score: data}
  	end

  	def food_allergies(data)
  		["dairy","egg","fish","shellfish","tree_nuts","peanuts","wheat","soyabean"].each do |alg|
        id_s = find_allergies(alg, 'yes')
        data << {count: BxBlockCatalogue::Product.where(id: id_s).count, product_rating: alg.titleize }
      end
      data = {count: total_count(data), food_allergies: data}
  	end

    def find_allergies(value, col)
      ingredients = BxBlockCatalogue::Ingredient.where("#{value} ILIKE ?", col).pluck(:product_id)
    end

    def food_preference(data)
      ['veg','nonveg','vegan_product','organic','gluteen_free','artificial_preservative','added_sugar','no_artificial_color'].each do |alg|
        id_s = find_food_pref(alg)
        alg = 'no_' + alg if alg == 'artificial_preservative' || alg == 'added_sugar' 
        data << {count: BxBlockCatalogue::Product.where(id: id_s).count, product_rating: alg.titleize }
      end
      data = {count: total_count(data), food_preference: data}
    end

    def find_food_pref(value)
      value = value == 'veg' || value =='nonveg' ? 'veg_and_nonveg' : value
      c_val = value == 'artificial_preservative' || value == 'added_sugar' || value == 'no_artificial_color' ? 'no' : 'yes'
      find_allergies(value, c_val)
    end

    def health_preference(data)
      health = ['Immunity', 'Gut Health', 'Holistic Nutrition', 'weight loss', 'Weight gain','Diabetic','Low Cholestrol','Heart Friendly','Energy and Vitality','Physical growth','Cognitive health', 'Mental health\mood boosting foods']
      health.each do |h_pref|
        unless h_pref == 'Mental health\mood boosting foods'
          prod =BxBlockCatalogue::SmartSearchService.new.p_health_preference({health_preference: h_pref}, BxBlockCatalogue::Product.all) 
          data << {count: prod.count, health_preference: h_pref }
        else
          data << {count: 0, health_preference: h_pref }
        end
      end
      data = {count: total_count(data), health_preference: data}
    end

    def functional_preference(data)
      ['energy','protein','fibre','vit_a','vit_c','total_sugar','trans_fat'].each do |f_p|
        total_p = BxBlockCatalogue::Ingredient.where.not("#{f_p} IS ? ", nil).pluck(:product_id)
        data << {count: total_p.compact.count, functional_preference: f_p.titleize }
      end
      data = {count: total_count(data), functional_preference: data}
    end

    def total_count(data)
      total = 0
      data.map{|count| total = total + count[:count] }
      total
    end
	end
end