module BxBlockCatalogue
  class SmartSearchService
  	# def smart_search(params)
   #    product = BxBlockCatalogue::Product.all
   #    # "pakaged_food", "row_food", "cooked_food"
   #    product = product.where.product_type(params[:food_type]) if params[:food_type].present?
   #    product = product.where.product_rating(params[:niq_score]) if params[:niq_score].present?
   #    product = p_category_filter(product, params)
   #    a = food_allergies(product, params) 
	  # end

	  # private

   #  def food_preferance
   #    ingredients = BxBlockCatalogue::Ingredient.all
   #    ingredients = ingredients.where.veg_and_nonveg(params[:veg_and_nonveg]) if params[:veg_and_nonveg].present?
   #    ingredients = ingredients.where.gluteen_free(params[:gluteen_free]) if params[:gluteen_free].present?
   #    ingredients = ingredients.where.added_sugar(params[:no_added_sugar]) if params[:no_added_sugar].present?
   #    ingredients = ingredients.where.artificial_preservative(params[:artificial_preservative]) if params[:artificial_preservative].present?
   #    ingredients = ingredients.where.organic(params[:organic]) if params[:organic].present?
   #    ingredients = ingredients.where.vegan_product(params[:vegan_product]) if params[:vegan_product].present? 
   #  end

   #  def food_allergies(product, params)
   #    # food allergiess filter
   #    allergies = eval(params[:allergies])
   #    ingredients = BxBlockCatalogue::Ingredient.all
   #    ingredients = ingredients.where('egg ILIKE ?', 'yes') if check('egg', ingredients, allergies)
   #    ingredients = ingredients.where('fish ILIKE ?', 'yes') if check('fish', ingredients, allergies)
   #    ingredients = ingredients.where('shellfish ILIKE ?', 'yes') if check('shellfish',ingredients,allergies)
   #    ingredients = ingredients.where('tree_nuts ILIKE ?', 'yes') if check('tree_nuts',ingredients,allergies)
   #    ingredients = ingredients.where('peanuts ILIKE ?', 'yes') if check('peanuts', ingredients, allergies)
   #    ingredients = ingredients.where('wheat ILIKE ?', 'yes') if check('wheat', ingredients, allergies)
   #    ingredients = ingredients.where('soyabean ILIKE ?', 'yes') if check('soyabean', ingredients, allergies)
   #    p_id = ingredients.pluck(:product_id) if ingredients.present?
   #    product.where(id: p_id) if p_id.present?
   #  end

   #  def p_category_filter(product, params)
   #  	#category filter 
   #    product = category_searching(product, 'Packaged_Food', params[:category]['packaged_food']) if params[:category]['packaged_food'].present? && product.present?
   #    product = category_searching(product, 'raw_food', params[:category]['raw_food']) if params[:category]['raw_food'].present? && product.present?
   #    product = category_searching(product, 'packaged_drink', params[:category]['packaged_drink']) if params[:category]['packaged_drink'].present? && product.present?
   #    product = category_searching(product, 'packaged_cheese_oil', params[:category]['packaged_cheese_oil']) if params[:category]['packaged_cheese_oil'].present? && product.present?
   #    product = category_searching(product, 'cooked_food', params[:category]['cooked_food']) if params[:category]['cooked_food'].present? && product.present?
   #    product
   #  end

   #  def category_searching(product, cat_name, category_filter)
   #    cat_id = BxBlockCategories::Category.find_by(category_type: cat_name) 
   #    product = product.where(category_id: cat_id).where(category_filter: category_filter)
   #  end

   #  def check(value, ingredients,allergies)
   #    allergies.include?(value) && ingredients.present?
   #  end
  end
end