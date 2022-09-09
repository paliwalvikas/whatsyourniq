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
      	niq_score(params, data)
      when "food_allergies"
      	food_allergies(params, data)
      when "food_preference"
        food_preference(params, data) 
      when "functional_preference"
        functional_preference(params, data)      
      when "health_preference"
        health_preference(params, data) 
      end
  	end

  	private

    def food_type(data)
			category = BxBlockCategories::Category.where.not(category_type: "cooked_food")
      category.each do |category|
        product = BxBlockCatalogue::Product.where(category_id: category.id)
        data << {count: product.count, food_type: category.category_type.titleize}
      end
      data = {count: total_count(data), food_type: data}
    end

  	def category(params, data)
      fav = fav_serach(params[:fav_search_id])
      product = fav.present? && fav[:food_type].present? ? find_product(fav) : BxBlockCatalogue::Product.where(id:0)
    	product.pluck(:food_drink_filter).uniq.each do |prd|
  			filter = []
    		prod =  product.food_drink_filter(prd)
    		uniq_p = filter_category_p(prod.pluck(:filter_category_id).uniq)
    		uniq_p.map{ |i| filter << {count: prod.filter_category_id(i.id).count, category_filter: i.name } }
      	data << {count: total_count(filter), category: ("packaged " + prd).titleize, category_filter: filter }
			end if product.present?
      c_ao = product.product_type("cheese_and_oil")
      c_prod = filter_category_p(c_ao.pluck(:filter_category_id).uniq)
      cao_filter = []
      c_prod.each do |cao|
        cao_filter << {count: c_ao.filter_category_id(cao.id).count, category_filter: cao.name }
      end
      data << {count:  total_count(cao_filter), category: 'packaged_cheese_and_oil'.titleize, category_filter: cao_filter }

      cat= BxBlockCategories::Category.where.not(category_type: ['packaged_food','cooked_food'])
      cat.each do |c|
        filter = []
        prod = product.where(category_id: c.id)
        u_f = filter_category_p(prod.pluck(:filter_category_id).uniq)
        u_f.map{ |i| filter << {count: prod.filter_category_id(i.id).count, category_filter: i.name } }
        data << {count: total_count(filter), category: c.category_type.titleize, category_filter: filter}
      end
			data = {count: total_count(data), category: data}
    end

    def sub_category(params, data)
      product = fav_filter_product(params, 'sub_category')
      product.food_drink_filters.keys.uniq.each do |prd|
        filter = []
        prod = product.where(food_drink_filter: prd)
        cat_filter = filter_category_p(prod.pluck(:filter_category_id).uniq)
        cat_filter.each do |cat_f|
          sub_filter =[]
          uniq_sub = filter_sub_category(prod.filter_category_id(cat_f.id).pluck(:filter_sub_category_id).uniq)
          uniq_sub.map{ |sub_c|
            sub_filter << {count: prod.filter_sub_category_id(sub_c.id).count, sub_category_filter: sub_c.name } 
          }
          filter << {count: total_count(sub_filter), category: cat_f.name , sub_category_filter: sub_filter } 
        end
        data << {count: total_count(filter), food_drink_filter: ("packaged " + prd).titleize, category_filter: filter }
      end 
      data = {count: total_count(data), sub_category: data}
    end

  	def niq_score(params, data)
      product = fav_filter_product(params, 'niq_score')
  		rating = product.order(product_rating: :asc).pluck(:product_rating).uniq.compact.delete_if(&:blank?) if product.present?
  		rating.each do |rat|
  			data << {count: product.where(product_rating: rat).count, product_rating: rat }
  		end 
  		data = {count: total_count(data), niq_score: data}
  	end

  	def food_allergies(params, data)
      product = fav_filter_product(params, 'food_allergies')
  		["dairy","egg","fish","shellfish","tree_nuts","peanuts","wheat","soyabean"].each do |alg|
        id_s = find_allergies(alg, 'yes')
        data << {count: product.where(id: id_s).count, product_rating: alg.titleize }
      end
      data = {count: total_count(data), food_allergies: data}
  	end

    def food_preference(params, data)
      product = fav_filter_product(params, 'food_preference')
      ['veg','nonveg','vegan_product','organic','gluteen_free','artificial_preservative','added_sugar','no_artificial_color'].each do |alg|
        id_s = find_food_pref(alg)
        alg = 'no_' + alg if alg == 'artificial_preservative' || alg == 'added_sugar' 
        data << {count: product.where(id: id_s).count, product_rating: alg.titleize }
      end 
      data = {count: total_count(data), food_preference: data}
    end

    def health_preference(params, data)
      product = fav_filter_product(params, 'health_preference')
      health = ['Immunity', 'Gut Health', 'Holistic Nutrition', 'weight loss', 'Weight gain','Diabetic','Low Cholesterol','Heart Friendly','Energy and Vitality','Physical growth','Cognitive health', 'Mental health\mood boosting foods']
      health.each do |h_pref|
        unless h_pref == 'Mental health\mood boosting foods'
          prod = product.present? ? BxBlockCatalogue::SmartSearchService.new.p_health_preference({health_preference: h_pref}, product) : []
          data << {count: prod.count, health_preference: h_pref }
        else
          data << {count: 0, health_preference: h_pref }
        end
      end 
      data = {count: total_count(data), health_preference: data}
    end

    def functional_preference(params, data)
      product = fav_filter_product(params, 'functional_preference')
      product = product.where.not(positive_good: nil, negative_not_good: nil).pluck(:positive_good, :negative_not_good, :id) if product.present?
      ['energy','protein','fibre','vit_a','vit_c','total_sugar','trans_fat'].each do |f_p|
        fp_count = []
        if product.present? 
          product.each do |val|
          ['high','low','medium'].each do |value| 
            fp_count << val[2] if val[0].include?("#{value} in #{f_p}") || val[1].include?("#{f_p} #{value}") || val[0].include?("#{value} in #{f_p}") || val[1].include?("#{f_p} #{value}") 
          end 
        end
        end
        data << {count: fp_count.uniq.count, functional_preference: f_p.titleize }
      end 
      data = {count: total_count(data), functional_preference: data}
    end

    def fav_filter_product(params, val)
      product = fav_product(params, val)
      product = product.present? ? product : BxBlockCatalogue::Product.where(id:0)
    end

    def filter_category_p(ids)
      BxBlockCategories::FilterCategory.where(id: ids)
    end

    def fav_product(params, val)
      if  params[:fav_search_id].present?
        fav = fav_serach(params[:fav_search_id])
        fav_value =  case val
                    when 'sub_category'
                      {food_type: fav.food_type, product_category: fav.product_category}
                    when 'niq_score'
                      {food_type: fav.food_type, product_category: fav.product_category, product_sub_category: fav.product_sub_category}
                    when 'food_preference'
                      {food_type: fav.food_type, product_category: fav.product_category, product_sub_category: fav.product_sub_category, niq_score: fav.niq_score, food_allergies: fav.food_allergies}
                    when 'food_allergies'
                      {food_type: fav.food_type, product_category: fav.product_category, product_sub_category: fav.product_sub_category, niq_score: fav.niq_score}
                    when 'functional_preference'
                      {food_type: fav.food_type, product_category: fav.product_category, product_sub_category: fav.product_sub_category, niq_score: fav.niq_score, food_allergies: fav.food_allergies, food_preference: fav.food_preference}
                    when 'health_preference'
                      {food_type: fav.food_type, product_category: fav.product_category, product_sub_category: fav.product_sub_category, niq_score: fav.niq_score, food_allergies: fav.food_allergies, food_preference: fav.food_preference, functional_preference: fav.functional_preference}
                    end if fav.present?
        product = fav.present? ? BxBlockCatalogue::SmartSearchService.new.smart_search(fav_value) : BxBlockCatalogue::Product.where(id:0)
      else
        product = BxBlockCatalogue::Product.all
      end
    end

    def filter_sub_category(ids)
      BxBlockCategories::FilterSubCategory.where(id: ids)
    end
  	
  	def find_product(params)
      food_type = params[:food_type].map{|val| value_is(val)}
      category = BxBlockCategories::Category.where(category_type: food_type)
      product = BxBlockCatalogue::Product.where(category_id: category.ids) #.pluck(:food_drink_filter).uniq
  	end

    def value_is(val)
      val = val.include?(' ') ? val.downcase.tr!(" ", "_") : val.downcase
    end

    def find_allergies(value, col)
      ingredients = BxBlockCatalogue::Ingredient.where("#{value} ILIKE ?", col).pluck(:product_id)
    end

    def find_food_pref(value)
      value = value == 'veg' || value =='nonveg' ? 'veg_and_nonveg' : value
      c_val = value == 'artificial_preservative' || value == 'added_sugar' || value == 'no_artificial_color' ? 'no' : 'yes'
      find_allergies(value, c_val)
    end


    def total_count(data)
      total = 0
      data.map{|count| total = total + count[:count] }
      total
    end

    def fav_serach(id)
      data = BxBlockCatalogue::FavouriteSearch.find_by(id: id)
      data.present? ? data : {}
    end
	end
end