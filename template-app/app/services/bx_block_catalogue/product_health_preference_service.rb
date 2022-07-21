module BxBlockCatalogue
    class HealthPreferenceService

    	# def health_preference(product, search)
     #    	ingredient = product.ingredient
    	#     ash = {vit_a: 300, vit_d: 4.5, vit_b1: 2.163, vit_c: 24, vit_e: 3, vit_b6: 0.57, vit_b12: 0.75, iron: 5.7, zinc: 5.1,selenium: 12, copper: 0.6, protein: 10.8, fibre: 6, calcium: 300, folate: 90, vit_b2: 0.6, iodine: 42, sugar: 5, fat: 3, gut_h: 6, h_protein: 10.8, energy: 40, cholestrol: 20, saturated_fat: 1.5}
     #  		case product.product_type
    	#     when 'solid'
    	#    		options(ingredient, ash, search)
    	#     when 'beverage'
    	#     	ash.each do |key, value| ash[key] = value/2 end
    	#    		options(ingredient, ash, search)
    	#     end
    	# end

    	# private

    	# def options(ingredient, ash,search)
    	# 	search[:health_pr].first.split(',')
    	# 	immunity(ingredient, ash) if h_pre.include?("immunity")
	    # 	gut_health(ingredient, ash[:gut_h]) 
	    # 	high_protein = check_greater?(ingredient[:protein], ash[:h_protein])
	    # 	physical_growth(ingredient, ash)
	    # 	cognitive_health(ingredient, ash)
	    # 	low_sugar = check_greater?(ingredient[:total_sugar], ash[:sugar])
	    # 	holistic_nutrition(ingredient,ash)
	    # 	weight_loss(ingredient, ash)
	    # 	weight_gain(ingredient, ash)
	    # 	fiber = ash[:fibre] == 3 ? 6 : 3
	    # 	diabetes(ingredient, ash, fibre)
	    # 	low_colesterol(ingredient, ash)
	    # 	heart_friendly(ingredient, ash, fiber) 
	    # 	energy_and_vitality(ingredient, ash)
    	# end

    	# def immunity(ingredient, val)
    	# 	(ingredient[:vit_a].to_f >= val[:vit_a] || ingredient[:vit_d].to_f >= val[:vit_d] ||ingredient[:vit_c].to_f >= val[:vit_c] ||	ingredient[:vit_e].to_f >= val[:vit_e] ||ingredient[:vit_b6].to_f >= val[:vit_b6] || ingredient[:vit_b12].to_f >= val[:vit_b12] || ingredient[:iron].to_f >= val[:iron] || ingredient[:zinc].to_f >= val[:zinc] ||ingredient[:selenium].to_f >= val[:selenium] || ingredient[:copper].to_f >= val[:copper]) && check_greater?(ingredient[protein], val[:protein]) && (check_greater?(ingredient[:fibre], val[:fibre]) ||  check_greater?(ing[:probiotic], 10**8) )
    	# end

    	# def gut_health(ingredient, fibre)
    	# 	check_greater?(ing[:probiotic], 10**8) || check_greater?(ingredient[:fibre], fibre)
    	# end

    	# def check_greater?(ing , val)
    	# 	ing.to_f >= val
    	# end
    	# def check_less?(ing, val)
    	# 	ing.to_f <= val
    	# end

    	# def physical_growth(ing, val)
    	# 	check_greater?(ing[:calcium], val[:calcium]) && check_greater?(ing[:vit_d], val[:vit_d]) && check_greater?(ing[:protein], val[:protein]) && (check_greater?(ing[:folate], val[:folate]) && check_greater?(ing[:vit_b12], val[:vit_b12] && check_greater?(ing[:vit_b6], val[:vit_b6]) && check_greater?(ing[:vit_b2], val[:vit_b2])) && check_greater?(ing[:fibre], val[:fibre]) 
    	# end

    	# def cognitive_health(ingr, val)
    	# 	check_greater?(ingr[:iron], val[:iron]) && check_greater?(ingr[:iodine], val[:lodine]) && check_greater?(ingr[:vit_b12], val[:vit_b12]) #pending
    	# end

    	# def holistic_nutrition(ing, val)
    	# 	(check_greater?(ing[:vit_b12], val[:vit_b12]) && check_greater?(ing[:vit_d], val[:vit_d]) && check_greater?(ing[:iron], val[:iron])) && check_greater?(ing[:protein], val[:protein]) && check_greater?(ing[:fibre], val[:fibre]) && (check_less?(ing[:total_sugar], val[:sugar]) && check_less?(ing[:sodium], 0.12) && check_less?(ing[:fat], val[:fat]))
    	# end

    	# def weight_loss(ing, val)
    	# 	check_less?(ing[:energy], val[:energy]) && check_greater?(ing[:protein], val[:protein]) && check_greater?(ing[:fibre], val[:fibre]) && micronutrients(ing, val, 'w')
    	# end

    	# def weight_gain(ing, val)
    	# 	(ing[:energy].to_f > val[:energy] ) && check_greater?(ing[:protein], val[:protein]) && check_greater?(ing[:fibre], val[:fibre]) && micronutrients(ing, val, 'w')
    	# end

    	# def diabetes(ing, val, fibre)
    	# 	check_less?(ing[:sugar], val[:sugar]) && check_greater?(ing[:protein], val[:protein]) && check_greater?(ing[:fibre], fibre) #pending
    	# end

    	# def low_colesterol(ing, val)
    	# 	check_less?(ing[:cholestrol], val[:cholestrol]) && check_less?(ing[:saturate], val[:saturated_fat]) #pending
    	# end

    	# def heart_friendly(ing, val, fibre)
    	# 	check_less?(ing[:cholestrol], val[:cholestrol]) && check_less?(ing[:saturate], val[:saturated_fat]) && check_greater?(ing[:fibre], fibre) && check_less?(ing[:total_sugar], val[:sugar]) #pending
    	# end

    	# def energy_and_vitality(ing, val)
    	# 	check_greater?(ing[:fibre], val[:fibre]) && check_greater?(ing[:protein], val[:protein]) && micronutrients(ing, val, 'e')
    	# end

    	# def micronutrients(ing, val, a)
    	# 	n = 0
    	# 	n +=1 if ing[:vit_b1].to_f > val[:vit_b1] 
    	# 	n +=1 if check_greater?(ing[:vit_b2], val[:vit_b2])
    	# 	n +=1 if check_greater?(ing[:vit_b6], val[:vit_b6])
    	# 	n +=1 if check_greater?(ing[:vit_b12], val[:vit_b12])
    	# 	return n >= 3 ? true : false unless a = 'w'
    	# 	n +=1 if check_greater?(ing[:vit_d], val[:vit_d])
    	# 	n +=1 if check_greater?(ing[:iron], val[:iron])
    	# 	n >= 3 ? true : false
    	# end
	    
	end
end