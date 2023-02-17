module BxBlockCatalogue
    class ProductHealthPreferenceService

      def health_pref_search(products, params)
        p_ids = []
        products.each do |product|
          flag = health_preference(product, params)
          p_ids << product.id if flag 
        end
        BxBlockCatalogue::Product.where(id: p_ids)
      end

    	def health_preference(product, search)
      	ingredient = product.ingredient
        return unless ingredient.present?
  	    ash = {vit_a: 300, vit_d: 4.5, vit_b1: 2.163, vit_c: 24, vit_e: 3, vit_b6: 0.57, vit_b12: 0.75, iron: 5.7, zinc: 5.1,selenium: 12, copper: 0.6, protein: 10.8, fibre: 6, calcium: 300, vit_b9: 90, vit_b2: 0.6, iodine: 42, sugar: 5, fat: 3, gut_h: 6, h_protein: 10.8, energy: 40, cholestrol: 20, saturated_fat: 1.5, lodine: 42}
    		case product.product_type
  	    when 'solid'
  	   		options(ingredient, ash, search, product)
  	    when 'beverage'
  	    	ash.each do |key, value| ash[key] = value/2 end
  	   		options(ingredient, ash, search, product)
  	    end
    	end

    	private

    	def options(ingredient, ash, search, product)
  	    fibre = ash[:fibre] == 3 ? 6 : 3
        case search
        when 'Immunity'
      		immunity(ingredient, ash)
        when 'Gut Health'
  	    	gut_health(ingredient, ash[:gut_h])
        when 'Holistic Nutrition'    
  	    	holistic_nutrition(ingredient,ash)
        when 'Weight loss'
  	    	weight_loss(ingredient, ash)
        when 'Weight gain'
  	    	weight_gain(ingredient, ash)
        when 'Diabetic'
  	    	diabetes(ingredient, ash, fibre)
        when 'Low Cholestrol'
  	    	low_colesterol(ingredient, ash)
        when 'Heart Friendly'
  	    	heart_friendly(ingredient, ash, fibre)
        when 'Energy and Vitality'
           ash[:protein] = product.product_type == 'solid' ? 5.4 : 2.7 
  	    	energy_and_vitality(ingredient, ash)
        when 'Physical growth' 
  	    	physical_growth(ingredient, ash)
        when 'Cognitive health'
  	    	cognitive_health(ingredient, ash)
        when 'High Protein'
  	    	high_protein = check_greater?(ingredient[:protein], ash[:h_protein])
        when 'Low Sugar'
  	    	low_sugar = check_less?(ingredient[:total_sugar], ash[:sugar])
        end
    	end

    	def immunity(ingredient, val)
    		(check_greater?(ingredient[:vit_a], val[:vit_a]) || check_greater?(ingredient[:vit_d], val[:vit_d]) || check_greater?(ingredient[:vit_c], val[:vit_c]) ||	check_greater?(ingredient[:vit_e], val[:vit_e]) || check_greater?(ingredient[:vit_b6], val[:vit_b6]) || check_greater?(ingredient[:vit_b12], val[:vit_b12]) || check_greater?(ingredient[:iron], val[:iron]) || check_greater?(ingredient[:zinc], val[:zinc]) || check_greater?(ingredient[:selenium], val[:selenium]) || check_greater?(ingredient[:copper], val[:copper])) && check_greater?(ingredient[:protein], val[:protein]) && (check_greater?(ingredient[:fibre], val[:fibre]) ||  check_greater?(ingredient[:probiotic], 10**8) )
    	end

    	def gut_health(ing, fibre)
    		check_greater?(ing[:probiotic], 10**8) || check_greater?(ing[:fibre], fibre)
    	end

    	def check_greater?(ing , val)
        return false unless ing.present?
    		ing.to_f >= val
    	end
      
    	def check_less?(ing, val)
        return false unless ing.present?
    		ing.to_f <= val
    	end

    	def physical_growth(ing, val)
    		(check_greater?(ing[:calcium], val[:calcium]) && check_greater?(ing[:vit_d], val[:vit_d])) && check_greater?(ing[:protein], val[:protein]) && ( (check_greater?(ing[:vit_b9], val[:vit_b9]) && check_greater?(ing[:vit_b12], val[:vit_b12]) && check_greater?(ing[:vit_b6], val[:vit_b6]) && check_greater?(ing[:vit_b2], val[:vit_b2])) || check_greater?(ing[:fibre], val[:fibre]) )
    	end

    	def cognitive_health(ingr, val)
    		(check_greater?(ingr[:iron], val[:iron]) || check_greater?(ingr[:iodine], val[:lodine]) || check_greater?(ingr[:vit_b12], val[:vit_b12]) ) || ( ingredient_herbs(ingr) || (ingr[:omega_3].to_f > 40) || ingr[:d_h_a].to_f == 40 ) 
    	end

    	def holistic_nutrition(ing, val)
    		 ( ( check_greater?(ing[:vit_b12], val[:vit_b12]) && check_greater?(ing[:vit_d], val[:vit_d]) ) || (check_greater?(ing[:vit_b12], val[:vit_b12])  && check_greater?(ing[:iron], val[:iron])) || (check_greater?(ing[:vit_d], val[:vit_d]) && check_greater?(ing[:iron], val[:iron]) ) ) && ( check_greater?(ing[:protein], val[:protein]) || check_greater?(ing[:fibre], val[:fibre]) || ( ( check_less?(ing[:total_sugar], val[:sugar]) && check_less?(ing[:sodium], 0.12) ) || (check_less?(ing[:total_sugar], val[:sugar]) && check_less?(ing[:total_fat], val[:fat])) || (check_less?(ing[:sodium], 0.12) && check_less?(ing[:total_fat], val[:fat] )) ) )
    	end

    	def weight_loss(ing, val)
    		condition = check_less?(ing[:energy], val[:energy]) && check_greater?(ing[:protein], val[:protein]) 
        condition ? true : false
        # check_greater?(ing[:fibre], val[:fibre]) || micronutrients(ing, val, 'w'))
    	end

    	def weight_gain(ing, val)
    		condition = ing[:energy].to_f > val[:energy] && check_greater?(ing[:protein], val[:protein])
        condition ? true : false
        # condition || check_greater?(ing[:fibre], val[:fibre]) || micronutrients(ing, val, 'w')
    	end

    	def diabetes(ing, val, fibre)
    		check_less?(ing[:total_sugar], val[:sugar]) && check_greater?(ing[:protein], val[:protein]) && check_greater?(ing[:fibre], fibre) && diab_ingredient_list(ing)
    	end

    	def low_colesterol(ing, val)
    		check_less?(ing[:cholestrol], val[:cholestrol]) && check_less?(ing[:saturate], val[:saturated_fat]) && energy_from_saturated_fat(ing)
    	end

      def energy_from_saturated_fat(ing)
        saturate_fat = ing.saturate.to_f
        energy_from = saturate_fat * 9
        percent = (energy_from / ing.energy.to_f) * 100
        value = percent < 10
      end

    	def heart_friendly(ing, val, fibre)
    		(check_less?(ing[:cholestrol], val[:cholestrol]) && check_less?(ing[:saturate], val[:saturated_fat]) ) && ( (check_greater?(ing[:fibre], fibre) && energy_from_saturated_fat(ing)) || ( check_less?(ing[:total_sugar], val[:sugar]) || check_less?(ing[:sodium], 0.12)  || check_less?(ing[:total_fat], val[:fat]) ) ) 
    	end

    	def energy_and_vitality(ing, val)
    		check_greater?(ing[:protein], val[:protein]) && (check_greater?(ing[:fibre], val[:fibre]) || micronutrients(ing, val, 'e'))
    	end

    	def micronutrients(ing, val, a)
    		n = 0
    		n +=1 if ing[:vit_b1].to_f > val[:vit_b1] 
    		n +=1 if check_greater?(ing[:vit_b2], val[:vit_b2])
    		n +=1 if check_greater?(ing[:vit_b6], val[:vit_b6])
    		n +=1 if check_greater?(ing[:vit_b12], val[:vit_b12])
    		return (n >= 3 ? true : false) unless a == 'w'
    		n +=1 if check_greater?(ing[:vit_d], val[:vit_d])
    		n +=1 if check_greater?(ing[:iron], val[:iron])
    		n >= 3 ? true : false
    	end
	    
      def diab_ingredient_list(ingr)
        list = ingr.product.ingredient_list.upcase if ingr.product.ingredient_list.present?
        return false unless list.present?
        list.include?('MAIDA') || list.include?('WHEAT') || list.include?('FLOUR') ? false : true
      end

      def ingredient_herbs(ingr)
        list = ingr.product.ingredient_list.upcase if ingr.product.ingredient_list.present?
        list.include?('BRAHMI') || list.include?('ASWAGANDHA') || list.include?('GOTUKOLA') || list.include?('SHANKHPUSHPI') || list.include?('GINKGO BILOBA') if list.present?
      end
	end
end