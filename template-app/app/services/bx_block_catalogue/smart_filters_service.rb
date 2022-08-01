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
        byebug
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
      	data << {count: total_count(filter), category: prd.titleize, category_filter: filter }
			end
			data = {count: total_count(data), category: data}
    end

    def sub_category(params, data)
      product = find_product(params)
      product.each do |prd|
        filter = []
        prod =  BxBlockCatalogue::Product.where(food_drink_filter: prd)
        uniq_p = prod.map{|p| p.filter_sub_category}.uniq
        uniq_p.map{ |i| filter << {count: prod.where(filter_sub_category_id: i.id).count, sub_category_filter: i.name } }
        data << {count: total_count(filter), sub_category: prd.titleize, category_filter: filter }
      end
      data = {count: total_count(data), sub_category: data}
    end
  	
  	def find_product(params)
  		category_id = BxBlockCategories::Category.category_type(params[:category_type].gsub(' ', '').underscore).ids
      product =  BxBlockCatalogue::Product.where(category_id: category_id).pluck(:food_drink_filter).uniq
  	end

  	def niq_score(data)
  		rating = BxBlockCatalogue::Product.all.order(product_rating: :asc).pluck(:product_rating).uniq.compact
  		rating.each do |rat|
  			data << {count: BxBlockCatalogue::Product.where(product_rating: rat).count, product_rating: rat }
  		end
  		data = {count: total_count(data), niq_score: data}
  	end

  	def food_allergies(data)
  		["dairy","egg","fish","shellfish","tree_nuts","peanuts","wheat","soyabean"].each do |alg|
        id_s = find_allergies(alg)
        data << {count: BxBlockCatalogue::Product.where(id: id_s).count, product_rating: alg }
      end
      data = {count: total_count(data), food_allergies: data}
  	end

    def find_allergies(value)
      ingredients = BxBlockCatalogue::Ingredient.where( "#{value} ILIKE ?", 'no').pluck(:product_id)
    end

    def food_preference(data)
      ['veg','nonveg','vegan_product','organic','artificial_preservative','added_sugar','gluteen_free','no_artificial_color'].each do |alg|
        id_s = find_food_pref(alg)
        data << {count: BxBlockCatalogue::Product.where(id: id_s).count, product_rating: alg }
      end
      data = {count: total_count(data), food_preference: data}
    end

    def find_food_pref(value)
      value = value == 'veg' || value =='nonveg' ? 'veg_and_nonveg' : value
      find_allergies(value)
    end

    def health_preference(data)
      health =   ['immunity', 'Gut Health', 'Holistic Nutrition', 'weight loss', 'Weight gain','Diabetic','Low Cholestrol','Heart Friendly','Energy & Vitality','Physical growth','Cognitive health', 'Mental health\mood boosting foods']
      health.each do |h_pref|
        p_id = []
        BxBlockCatalogue::Product.all.each do |product|
          prod = BxBlockCatalogue::ProductHealthPreferenceService.new.health_preference(product, h_pref)
          p_id << (prod == true ? product.id : nil)
        end
        data << {count: p_id.compact.count, health_preference: h_pref }
      end
      data = {count: total_count(data), health_preference: data}
    end

    def functional_preference(data)
      ['energy','protein','fibre','vit_a','vit_c','total_sugar','trans_fat'].each do |f_p|
        total_p = BxBlockCatalogue::Ingredient.where.not("#{f_p} IS ? ", nil).pluck(:product_id)
        data << {count: total_p.compact.count, functional_preference: f_p }
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