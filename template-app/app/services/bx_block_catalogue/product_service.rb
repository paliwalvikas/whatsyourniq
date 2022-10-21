module BxBlockCatalogue
	class ProductService

		attr_accessor :ingredient, :product_type

		 GOOD_INGREDIENTS = { protein: [54, 'g'], fibre: [32, 'g'], vit_a: [1000, 'mg'], vit_c: [80, 'mg'], vit_d: [15, 'mg'], iron: [19, 'mg'], calcium: [1000, 'mg'],
                         magnesium: [440, 'mg'], potassium: [3500, 'mg'], zinc: [17, 'mg'], iodine: [150, 'ug'], vit_b1: [1.4, 'mg'], vit_b2: [2.0, 'mg'], vit_b3: [1.4, 'mg'], vit_b6: [1.9, 'mg'], vit_b12: [2.2, 'ug'], vit_e: [10, 'mg'], vit_b7: [40, 'mcg'], vit_b5: [5, 'mg'], phosphorus: [1000, 'mg'], copper: [2, 'mg'], manganese: [4, 'mg'], chromium: [50, 'mca'], selenium: [40, 'mca'], chloride: [2050, 'mg'] }.freeze
    NOT_SO_GOOD_INGREDIENTS = { saturated_fat: [22, 'g'], sugar: [90, 'g'], sodium: [2000, 'mg'], calories: [2110, 'kcal']}.freeze


		def initialize(ingredient, product_type )
			@ingredient = ingredient
			@product_type = product_type
		end

		def vit_min_value 
      ing = ingredient
      vit_min = []
      val = 0
      if product_type == "solid"
        micro_columns.each do |clm|
          good_value = GOOD_INGREDIENTS[:"#{clm}"]
          mp = ing.send(clm).to_f
          val = BxBlockCatalogue::VitaminValueService.new().set_vitamin_value_for_solid(clm, mp)
          # next if mp.zero? || good_value.nil?
          if val <= 0.5 
            vit_min_level = 'Low'
          elsif val >= 0.6 && val < 1
            vit_min_level = 'Medium'
          elsif val >= 1
            vit_min_level = 'High'
          end
          value = checking_good_value(mp, clm, vit_min_level)
          vit_min << {"#{clm}": value} 
        end
      elsif product_type == "beverage" || product_type == "cheese_and_oil"
        micro_columns.each do |clm|
          good_value = GOOD_INGREDIENTS[:"#{clm}"]
          mp = ing.send(clm).to_f
          val = BxBlockCatalogue::VitaminValueService.new().set_vitamin_value_for_beaverage(clm, mp).to_f
          if val <= 0.5 
            vit_min_level = 'Low'
          elsif val >= 0.6 && val < 1
            vit_min_level = 'Medium'
          elsif val >= 1
            vit_min_level = 'High'
           elsif val
          end
          value = checking_good_value(mp, clm, vit_min_level)
          vit_min << {"#{clm}": value} 
        end
      end
      vit_min
    end

    def micro_columns
      micro_columns = BxBlockCheeseAndOil::PositiveIngredient.column_names + BxBlockCheeseAndOil::MicroIngredient.column_names
      micro_columns = micro_columns.reject! {|micro_columns| micro_columns =~ /id|point|created_at|updated_at|fruit_veg|fibre|protein/i}
    end

    def dietary_fibre
    	fb = []
    	if ingredient.fibre.present?
	      pro = ingredient.fibre.to_f
	      case product_type
	      when 'solid'
	        if pro < 3.0
	         fibre_level  = 'Low'
	        elsif pro >= 3.0 && pro < 6.0
	        	fibre_level = 'Medium'
	        elsif pro >= 6.0
	        	fibre_level ='High'
	        end
	         fb << { Fibre: checking_good_value(pro, 'fibre', fibre_level)}
	      when 'beverage'
	        if pro < 1.5
	         fibre_level  = 'Low'
	        elsif pro >= 1.5 && pro < 3.0
	        	fibre_level = 'Medium'
	        elsif pro >= 3.0
	        	fibre_level ='High'
	        end
	         fb << { Fibre: checking_good_value(pro, 'fibre', fibre_level)}
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
	          protein_level =  'Low'
	        elsif pro >= 5.4 && pro < 10.8
	          protein_level =  'Medium'
	        elsif pro >= 10.8
	          protein_level = 'High'
	        end
	        value << { Protein: checking_good_value(pro, 'protein', protein_level)} 
	      when 'beverage'
	        if pro < 2.7
	          protein_level =  'Low'
	        elsif pro >= 2.7 && pro < 5.4
	          protein_level =  'Medium'
	        elsif pro >= 5.4
	          protein_level = 'High'
	        end
	        value << { Protein: checking_good_value(pro, 'protein', protein_level)} 
	       end
	    elsif ingredient.protein == nil
	    	protein_level = "N/A"
	    	value << { Protein: checking_good_value(pro, 'protein', protein_level)}
	    end
    end

    def checking_good_value(ing_vlue, ing, level)
    	GOOD_INGREDIENTS[:"#{ing}"] == nil || GOOD_INGREDIENTS[:"#{ing}"] == "N/A" ? good_value = 0 :  good_value = GOOD_INGREDIENTS[:"#{ing}"]
    	ing_vlue == nil || ing_vlue == "N/A" ? ing_vlue = 0 : ing_vlue
      if good_value.present?
        value_percent = ((ing_vlue / good_value[0]) * 100).round if good_value[0] > 0
        if ing_vlue == 0 
           [percent: value_percent, upper_limit: "N/A", level: "N/A", quantity: "#{ing_vlue.round(2)} #{good_value[1]}", name: ing]
        else
          [percent: value_percent, upper_limit: good_value[0], level: level, quantity: "#{ing_vlue.round(2)} #{good_value[1]}", name: ing] 
        end
      end
    end

    # def fat_value
    #   return unless ingredient.fat.present?
    #   pro = ingredient.fat.to_f
    #   fb = []
    #   case product_type
    #   when 'solid'
    #   fat_level = if pro < 0.5 
    #       'Free'
    #     elsif pro < 3
    #       'Low'
    #     end
    #     value = [level: fat_level, name: "Fat"] if fat_level.present? 
    #   when 'beverage'
    #     fat_level = 'Free' if  pro < 0.5 
    #     fat_level = 'Low' if  pro < 1.5
    #     value = [level: fat_level, name: "Fat"] if fat_level.present?
    #   end
    #   value
    # end

    # def trans_fat_value
    #   return unless ingredient.trans_fat.present?
    #   pro = ingredient.trans_fat.to_f
    #   energy = ingredient.energy.to_f
    #   fb = []
    #   case product_type
    #   when 'solid', 'beverage','cheese_and_oil'
    #   t_fat_level = if pro < 0.2
    #       'Low'
    #     elsif energy.positive? && pro > 0.09 || energy.between?(0, 7) && pro > 0.18 || energy.between?(7,14) && pro > 0.27 || energy.between?(14,22) && pro > 0.36 || energy.between?(22, 29) && pro > 0.44 || energy.between?(29,36) && pro > 0.53 || energy.between?(36,43) && pro > 0.62 || energy.between?(43, 50) && pro > 0.71 || energy.between?(50, 57) && pro > 0.8 || energy.between?(57, 64) && pro > 0.89
    #       'High'
    #     end
    #     value = [level: t_fat_level, name: "Trans Fat"] if t_fat_level.present? 
    #   end
    #   value
    # end

    
    # def cholesterol_value
    #   return unless ingredient.cholestrol.present?
    #   pro = ingredient.cholestrol.to_f
    #   sat_fat = ingredient.saturate.to_f
    #   fb = []
    #   case product_type
    #   when 'solid'
    #   cho_level = if pro < 5 && sat_fat < 1.5 && energy_from_saturated_fat 
    #       'Free'
    #     elsif pro < 20 && sat_fat < 1.5 && energy_from_saturated_fat
    #       'Low'
    #     end
    #     value = [level: cho_level, name: "Cholesterol"] if cho_level.present? 
    #   when 'beverage'
    #     cho_level = 'Free' if  pro < 5 && sat_fat < 0.75 && energy_from_saturated_fat 
    #     cho_level = 'Low' if  pro < 10 && sat_fat < 0.75 && energy_from_saturated_fat
    #     value = [level: cho_level, name: "Cholesterol"] if cho_level.present?
    #   end
    #   value
    # end

    def product_sat_fat
      return if ingredient.saturate.nil?
      saturate_fat = ingredient.saturate.to_f
      energy = ingredient.energy.to_f
      pro_sat_fat = case product_type
      when 'solid'
        if saturate_fat <= 0.1
          return { saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Free') }
        elsif saturate_fat > 0.1 && saturate_fat <= 1.5 
          return { saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Low') }
        elsif saturate_fat >= 1.5 
          value = BxBlockCatalogue::VitaminValueService.new().saturated_fat_clc(saturate_fat, energy)
          return { saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated_fat', value) } 
        end
      when 'beverage'
        if saturate_fat <= 0.1
          return { saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Free') }
        elsif saturate_fat > 0.1 && saturate_fat <= 0.75 
          return { saturate_fat:checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Low') }
        elsif saturate_fat >= 2 
          value = BxBlockCatalogue::VitaminValueService.new().saturated_fat_clc(saturate_fat, energy)
          rating = value == 'High' ? false : true 
          return { saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated_fat', value) } 
        end
      end
    end

    def product_sodium_level
      energy = ingredient.energy.to_f
      return nil if ingredient.sodium.nil?
      sodium = ingredient.sodium.to_f
      case product_type
      when 'solid'
        if sodium < 0.5
          return { sodium: checking_not_so_good_value(sodium, 'sodium', 'Free') }
        elsif sodium >= 0.5 && sodium <= 5.0
          return { sodium: checking_not_so_good_value(sodium, 'sodium', 'Low') }
        elsif sodium > 5.0
          value = BxBlockCatalogue::VitaminValueService.new().sodium_level_clc(sodium, energy)
          return { sodium: checking_not_so_good_value(sodium, 'sodium', value) }
        end
      when 'beverage'
        if sodium < 0.5
          return { sodium: checking_not_so_good_value(sodium, 'sodium', 'Free') }
        elsif sodium >= 0.5 && sodium <= 2.5
          return { sodium: checking_not_so_good_value(sodium, 'sodium', 'Low') }
        elsif sodium > 2.5
          value = BxBlockCatalogue::VitaminValueService.new().sodium_level_clc(sodium, energy)
          return { sodium: checking_not_so_good_value(sodium, 'sodium', value) }  
        end
      end
    end

     def product_sugar_level
      return if ingredient.total_sugar.nil?
      energy = ingredient.energy.to_f
      sugar = ingredient.total_sugar.to_f
      pro_sugar_val = case product_type
      when 'solid'
        if sugar <= 0.5
          return { sugar: checking_not_so_good_value(sugar, 'sugar', 'Free') }
        elsif sugar >= 0.5 && sugar <= 5.0
          return { sugar: checking_not_so_good_value(sugar, 'sugar', 'Low')  }
        elsif sugar > 5.0
          value = BxBlockCatalogue::VitaminValueService.new().suger_clc(product_type, sugar, energy)
          return { sugar: checking_not_so_good_value(sugar, 'sugar', value) } 
        end
      when 'beverage'
        if sugar < 0.5
          return { sugar: checking_not_so_good_value(sugar, 'sugar', 'Free') }
        elsif sugar >= 0.5 && sugar <= 2.5
          return { sugar: checking_not_so_good_value(sugar, 'sugar', 'Low') }
        elsif sugar > 2.5
          value = BxBlockCatalogue::VitaminValueService.new().suger_clc(product_type, sugar, energy)
          return { sugar: checking_not_so_good_value(sugar, 'sugar', value) }
        end
      end
    end

    def checking_not_so_good_value(ing_vlue, ing, level)
      return unless (not_so_good_value = NOT_SO_GOOD_INGREDIENTS[:"#{ing}"]).present?
      value_percent = ((ing_vlue / not_so_good_value[0]) * 100).round
      [percent: value_percent, upper_limit: not_so_good_value[0], level: level, quantity: "#{ing_vlue.round(2)} #{not_so_good_value[1]}", name: ing]
    end

		def calculation_for_rdas
      good_ingredient = []
      not_so_good_ingredient = []
      good_ingredient << vit_min_value
      good_ingredient << dietary_fibre
      good_ingredient << protein_value
      # not_so_good_ingredient << fat_value
      # not_so_good_ingredient << trans_fat_value
      # not_so_good_ingredient << cholesterol_value
      not_so_good_ingredient <<  product_sat_fat
      not_so_good_ingredient << product_sugar_level
      not_so_good_ingredient << product_sodium_level
      data = { good_ingredient: good_ingredient.flatten.compact, not_so_good_ingredient: not_so_good_ingredient.flatten.compact }
    end

	end
end