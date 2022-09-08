module BxBlockCatalogue
	class ProductService

		attr_accessor :ingredient, :product_type

		 GOOD_INGREDIENTS = { protein: [54, 'g'], fibre: [32, 'g'], vit_a: [1000, 'ug'], vit_c: [80, 'mg'], vit_d: [15, 'iu'], iron: [19, 'mg'], calcium: [1000, 'mg'],
                         magnesium: [440, 'mg'], potassium: [3500, 'mg'], zinc: [17, 'mg'], iodine: [150, 'ug'], vit_b1: [1.4, 'mg'], vit_b2: [2.0, 'mg'], vit_b3: [1.4, 'mg'], vit_b6: [1.9, 'mg'], vit_b12: [2.2, 'ug'], vit_e: [10, 'mg'], vit_b7: [40, 'mcg'], vit_b5: [5, 'mg'], phosphorus: [1000, 'mg'], copper: [2, 'mg'], manganese: [4, 'mg'], chromium: [50, 'mca'], selenium: [40, 'mca'], chloride: [2050, 'mg'] }.freeze

    NOT_SO_GOOD_INGREDIENTS = { saturated: [22, 'g'], sugar: [90, 'mg'], sodium: [2000, 'mg'], calories: [0.0, 'kcal']}.freeze


		def initialize(ingredient, product_type )
			@ingredient = ingredient
			@product_type = product_type
		end


		def vit_min_value 
      ing = ingredient
      vit_min = []
      micro_columns.each do |clm|
        good_value = GOOD_INGREDIENTS[:"#{clm}"]
        mp = ing.send(clm).to_f
        unless good_value.nil? && mp.zero?
	        if (mp < 0.6)
	          vit_min_level = 'low'
	        elsif (mp >= 0.6 && mp < 1.0)
	        	vit_min_level = 'medium'
	        elsif (mp >= 1.0)
	        	vit_min_level = 'high'
	        end
	        value = checking_good_value(mp, clm, vit_min_level)
          vit_min << {"#{clm}": value} 
	      else
	        value = checking_good_value(mp, clm, 'N/A')
	        vit_min << {"#{clm}": value} 
        end
      end
      vit_min
    end

    def micro_columns
      micro_columns = BxBlockCatalogue::Ingredient.column_names - (BxBlockCheeseAndOil::PositiveIngredient.column_names + BxBlockCheeseAndOil::NegativeIngredient.column_names + ['product_id'])
    end

    def dietary_fibre
    	fb = []
    	if ingredient.fibre.present?
	      pro = ingredient.fibre.to_f
	      case product_type
	      when 'solid'
	        if pro < 3.0
	         fibre_level  = 'low'
	        elsif pro >= 3.0 && pro < 6.0
	        	fibre_level = 'medium'
	        elsif pro >= 6.0
	        	fibre_level ='high'
	        end
	        # fibre_level = (pro >= 3.0 && pro < 6.0 ? 'medium' : 'high')
	        fb << { Fibre: checking_good_value(pro, 'fibre', fibre_level)}
	        # end
	      when 'beverage'
	        if pro < 1.5
	         fibre_level  = 'low'
	        elsif pro >= 1.5 && pro < 3.0
	        	fibre_level = 'medium'
	        elsif pro >= 3.0
	        	fibre_level ='high'
	        end
	        # fibre_level = (pro >= 1.5 && pro < 3.0 ? 'medium' : 'high')
	        fb << { Fibre: checking_good_value(pro, 'fibre', fibre_level)}
	        # end
	      end
	    else 
	    	fb << { Fibre: checking_good_value(pro, 'fibre', "N/A")}
	    end
      fb
    end

    def protein_value
    	value = []
    	if ingredient.protein.present?
	      pro = ingredient.protein.to_f
	      case product_type
	      when 'solid'
	        if pro < 5.4
	          protein_level =  'low'
	        elsif pro >= 5.4 && pro <= 10.8
	          protein_level =  'medium'
	        elsif pro > 10.8
	          protein_level =  'high'
	        end
	        # protein_level = (pro >= 5.4 && pro < 10.8 ? 'medium' : 'high')
	        value << { Protein: checking_good_value(pro, 'protein', protein_level)} 
	        # end
	      when 'beverage'
	        if pro < 2.7
	          protein_level =  'low'
	        elsif pro >= 2.7 && pro < 5.4
	          protein_level =  'medium'
	        elsif pro >= 5.4
	          protein_level = 'high'
	        end
	        # protein_level = (pro >= 2.7 && pro < 5.4 ? 'medium' : 'high ')
	        value << { Protein: checking_good_value(pro, 'protein', protein_level)} 
	        # end
	       end
	    elsif ingredient.protein == nil
	    	protein_level = "N/A"
	    	value << { Protein: checking_good_value(pro, 'protein', protein_level)}
	    end
    end

    def calories_energy
    	energy = ingredient.energy
    	if energy.present?
	      energy = energy.to_f
	      energy_level = case product_type
          when 'solid'
            'low' if energy <= 40
            'N/A'  if energy > 40
          when 'beverage'  
            'free' if energy <= 4
            'low'  if energy > 4 && energy <= 20
            'N/A'   if energy > 20 
          end
      elsif energy == nil 
      	energy = "N/A"
	    end
      return checking_good_value(energy, 'calories', energy_level)
    end

    def product_sat_fat
      saturate_fat = ingredient.saturate.to_f
      return "N/A" if saturate_fat.zero?
      pro_sat_fat = case product_type
      when 'solid'
        if saturate_fat <= 0.1
          [{ Saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated', 'free')}, true]
        elsif saturate_fat > 0.1 && saturate_fat <= (1.5 + energy_from_saturated_fat)
          [{ Saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated', 'low')}, true]
        elsif saturate_fat >= 10.8
          [{ Saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated', 'high')}, false]
        end
      when 'beverage'
        if saturate_fat <= 0.1
          [{ Saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated', 'free')}, true]

        elsif saturate_fat > 0.1 && saturate_fat <= (0.75 + energy_from_saturated_fat)
          [{ Saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated', 'low')}, true]
        elsif saturate_fat >= 5.4
          [{ Saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated', 'high')}, false]
        end
      end
      pro_sat_fat || []
    end

    def product_sugar_level
      energy = ingredient.energy.to_f
      sugar = ingredient.total_sugar.to_f
      if sugar >= 0
	      pro_sugar_val = case product_type
	      when 'solid'
	        if sugar < 0.5
	          [{ Sugar: checking_not_so_good_value(sugar, 'sugar', 'free')}, true]
	        elsif sugar >= 0.5 && sugar < 5.0
	          [{ Sugar: checking_not_so_good_value(sugar, 'sugar', 'low')}, true]
	        elsif energy.between?(0,80) && sugar > 4.5 || energy.between?(80,160) && sugar > 9 || energy.between?(160,240) && sugar > 13.5 || energy.between?(240,320) && sugar > 18 || energy.between?(320,400) && sugar > 22.5 || energy.between?(400,480) && sugar > 27 || energy.between?(480,560) && sugar > 31 || energy.between?(560,640) && sugar > 36 || energy.between?(640, 720) && sugar > 40 || energy.between?(720, 800) && sugar > 45
	          [{ Sugar: checking_not_so_good_value(sugar, 'sugar', 'high')}, false]
	        end
	      when 'beverage'
	        if sugar < 0.5
	          [{ Sugar: checking_not_so_good_value(sugar, 'sugar', 'free')}, true]
	        elsif sugar >= 0.5 && sugar < 2.5
	          [{ Sugar: checking_not_so_good_value(sugar, 'sugar', 'free')}, true]
	        elsif energy.positive? && sugar.positive? || energy.between?(0,7) && sugar > 1.5 || energy.between?(7,14) && sugar > 3 || energy.between?(14,22) && sugar > 4.5 || energy.between?(22,29) && sugar > 6 || energy.between?(29,36) && sugar > 7.5 || energy.between?(36,43) && sugar > 9 || energy.between?(43,50) && sugar > 10.5 || energy.between?(50, 57) && sugar > 12 || energy.between?(57, 64) && sugar > 13.5
	          [{ Sugar: checking_not_so_good_value(sugar, 'sugar', 'high')}, false]
	        end
	      end
	    elsif ingredient.total_sugar == nil 
	    	[{ Sugar: checking_not_so_good_value('N/A', 'sugar', 'free')}, true]
	    end
      pro_sugar_val || []
    end

    def product_sodium_level
      energy = ingredient.energy.to_f
      sodium = ingredient.sodium.to_f
      return "N/A" if sodium.zero?
      case product_type
      when 'solid'
        if sodium < 0.5
          return [{ Sodium: checking_not_so_good_value(sodium, 'sodium', 'free')}, true]
        elsif sodium >= 0.5 && sodium < 5.0
          return [{ Sodium: checking_not_so_good_value(sodium, 'sodium', 'low')}, true]
        elsif energy.between?(0,80) && sodium > 90 || energy.between?(80,160) && sodium > 180 || energy.between?(160,240) && sodium > 270 || energy.between?(240,320) && sodium > 360 || energy.between?(320,400) && sodium > 450 || energy.between?(400,480) && sodium > 540 || energy.between?(480,560) && sodium > 630 || energy.between?(560,640) && sodium > 720 || energy.between?(640, 720) && sodium > 810 || energy.between?(720, 800) && sodium > 900
          return [{ sodium: checking_not_so_good_value(sodium, 'sodium', 'high')}, false]
        end
      when 'beverage'
        if sodium < 0.5
          return [{ Sodium: checking_not_so_good_value(sodium, 'sodium', 'free')}, true]
        elsif sodium >= 0.5 && sodium < 2.5
          return [{ Sodium: checking_not_so_good_value(sodium, 'sodium', 'low')}, true]
        elsif energy.positive? && sodium > 90 || energy.between?(0,7) && sodium > 180 || energy.between?(7,14) && sodium > 270 || energy.between?(14,22) && sodium > 360 || energy.between?(22,29) && sodium > 450 || energy.between?(29,36) && sodium > 540 || energy.between?(36,43) && sodium > 630 || energy.between?(43,50) && sodium > 720 || energy.between?(50, 57) && sodium > 810 || energy.between?(57, 64) && sodium > 900
          return [{ sodium: checking_not_so_good_value(sodium, 'sodium', 'high')}, false]
        end
      end
      []
    end

    def checking_good_value(ing_vlue, ing, level)
    	GOOD_INGREDIENTS[:"#{ing}"] == nil || GOOD_INGREDIENTS[:"#{ing}"] == "N/A" ? good_value = 0 :  good_value = GOOD_INGREDIENTS[:"#{ing}"]
    	ing_vlue == nil || ing_vlue == "N/A" ? ing_vlue = 0 : ing_vlue
      if good_value.present?
        value_percent = ((ing_vlue / good_value[0]) * 100).round if good_value[0] > 0
        [percent: value_percent, upper_limit: good_value[0], level: level, quantity: "#{ing_vlue.round(2)} #{good_value[1]}"]
      end
    end

    def checking_not_so_good_value(ing_vlue, ing, level)
      return unless (not_so_good_value = NOT_SO_GOOD_INGREDIENTS[:"#{ing}"]).present?
    	ngv = (not_so_good_value = NOT_SO_GOOD_INGREDIENTS[:"#{ing}"])
    	ing_vlue == nil ? ing_vlue = 0 : ing_vlue
    	if ngv.present?
        value_percent = ((ing_vlue / not_so_good_value[0]) * 100).round
        [percent: value_percent, upper_limit: not_so_good_value[0], level: level, quantity: "#{ing_vlue.round(2)} #{not_so_good_value[1]}"]
      end
    end

    def energy_from_saturated_fat
      saturate_fat = ingredient.saturate.to_f
      energy_from = saturate_fat * 9
      percent =  (energy_from / ingredient.energy.to_f) * 100
      value = if percent < 10
                percent
              else
                0.0
              end
    end

		def calculation_for_rdas
      good_ingredient = []
      not_so_good_ingredient = []
      good_ingredient << vit_min_value
      good_ingredient << dietary_fibre
      good_ingredient << protein_value
      not_so_good_ingredient << {Calories: calories_energy} 
      saturate_fat = product_sat_fat
      # good_ingredient << saturate_fat[0] if saturate_fat&.last == true 
      not_so_good_ingredient << saturate_fat[0] if saturate_fat&.last == false 
      sugar = product_sugar_level
      # good_ingredient << sugar[0] if sugar&.last == true 
      not_so_good_ingredient << sugar[0] if sugar&.last == false 
      sodium = product_sodium_level
      good_ingredient << sodium[0] if sodium&.last == true 
      not_so_good_ingredient << sodium[0] if sodium&.last == false 
      
      data = {
        good_ingredient: good_ingredient.flatten.compact,
        not_so_good_ingredient: not_so_good_ingredient.flatten.compact
      }
    end
	end

end