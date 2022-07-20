module BxBlockCatalogue
  class SmartFiltersService

  	def filters(params)
  		data = []
  		case params[:query]
  		when  "food_type"
			category = BxBlockCategories::Category.all
	      category.each do |category|
	        product = BxBlockCatalogue::Product.where(category_id: category.id)
	        data << {count: product.count, food_type: category.category_type}
	      end
      when "category"
        data = category(params, data)
      when "sub_category"
      	data = sub_category(params, data)
      end
      data
  	end

  	private

  	def category(params, data)
      product = find_product(params)
    	product.each do |prd|
    		product =  BxBlockCatalogue::Product.where(food_drink_filter: prd)
    		uniq = product.pluck(:category_filter).uniq
  			filter = []
    		uniq.map{|i| filter << {count: product.where(category_filter: i).count, category_filter: i }} 
      	data << {count: product.count, category: prd, category_filter: filter }
			end
			data
    end

    def sub_category
      product = find_product(params)
    end
  	
  	def find_product(params) 
  		category_id =  BxBlockCategories::Category.category_type(params[:category_type]).ids
      product =  BxBlockCatalogue::Product.where(category_id: category_id).pluck(:food_drink_filter).uniq
  	end

	end
end