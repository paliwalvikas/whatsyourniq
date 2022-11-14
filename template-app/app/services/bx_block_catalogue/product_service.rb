module BxBlockCatalogue
	class ProductService

		attr_accessor :ingredient, :product_type

		 GOOD_INGREDIENTS = { protein: [54, 'g'], fibre: [32, 'g'], vit_a: [1000, 'mg'], vit_c: [80, 'mg'], vit_d: [15, 'mg'], iron: [19, 'mg'], calcium: [1000, 'mg'],
                         magnesium: [440, 'mg'], potassium: [3500, 'mg'], zinc: [17, 'mg'], iodine: [150, 'ug'], vit_b1: [1.4, 'mg'], vit_b2: [2.0, 'mg'], vit_b3: [1.4, 'mg'], vit_b6: [1.9, 'mg'], vit_b12: [2.2, 'ug'], vit_e: [10, 'mg'], vit_b7: [40, 'mcg'], vit_b5: [5, 'mg'], phosphorus: [1000, 'mg'], copper: [2, 'mg'], manganese: [4, 'mg'], chromium: [50, 'mca'], selenium: [40, 'mca'], chloride: [2050, 'mg'] }.freeze
    NOT_SO_GOOD_INGREDIENTS = { saturated_fat: [22, 'g'], sugar: [90, 'g'], sodium: [2000, 'mg'], calories: [2110, 'kcal'], cholesterol: [300, 'mg'], total_fat: [67, 'g'], trans_fat: [2, 'g']}.freeze


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

    def trans_fat_value
      if ingredient.trans_fat.present?
        trans_fat = ingredient.trans_fat.to_f
        energy = ingredient.energy.to_f
        case product_type
        when 'solid', 'beverage','cheese_and_oil'
        level = if trans_fat < 0.2
            'Low'
          elsif trans_fat > 0.2
            BxBlockCatalogue::VitaminValueService.trans_fat_clc(trans_fat, energy)
          end
        end
        return { trans_fat: checking_not_so_good_value(trans_fat, 'trans_fat', level) } 
      else
        return { trans_fat: checking_not_so_good_value(trans_fat, 'trans_fat', "N/A") } 
      end
    end

    def total_fat_value
      if ingredient.total_fat.present?
        pro = ingredient.total_fat.to_f
        case product_type
        when 'solid'
        fat_level = if pro <= 0.5 || pro == 0
            'Free'
          elsif pro <= 3
            'Low'
          end
        when 'beverage'
          fat_level = 'Free' if  pro <= 0.5 || pro == 0
          fat_level = 'Low' if  pro <= 1.5
        end
        return { total_fat: checking_not_so_good_value(pro, 'total_fat', fat_level) } 
      else
        return { total_fat: checking_not_so_good_value(pro, 'total_fat', "N/A") }
      end
    end
    
    def cholesterol_value
      if ingredient.cholestrol.present?
        cholestrol = ingredient.cholestrol.to_f
        sat_fat = ingredient.saturate.to_f
        case product_type
        when 'solid'
        level = if cholestrol < 5 && sat_fat < 1.5 && energy_from_saturated_fat 
            "Free"
          elsif cholestrol < 20 && sat_fat < 1.5 && energy_from_saturated_fat
            "Low"
          end
        when 'beverage'
          level = 'Free' if  cholestrol < 5 && sat_fat < 0.75 && energy_from_saturated_fat 
          level = 'Low' if  cholestrol < 10 && sat_fat < 0.75 && energy_from_saturated_fat
        end
        return { cholestrol: checking_not_so_good_value(cholestrol, 'cholesterol', level) } 
      else
        return { cholestrol: checking_not_so_good_value(cholestrol, 'cholesterol', "N/A") }
      end
    end

    def product_sat_fat
      if ingredient.saturate.present?
        saturate_fat = ingredient.saturate.to_f
        energy = ingredient.energy.to_f
        pro_sat_fat = case product_type
        when 'solid'
          if saturate_fat <= 0.1
            level = "Free"
          elsif saturate_fat > 0.1 && saturate_fat <= 1.5 
            level = "Low"
          elsif saturate_fat >= 1.5 
            level = BxBlockCatalogue::VitaminValueService.new().saturated_fat_clc(saturate_fat, energy)
          end
        when 'beverage'
          if saturate_fat <= 0.1
            level = "Free"
          elsif saturate_fat > 0.1 && saturate_fat <= 0.75 
            level = "Low"
          elsif saturate_fat >= 2 
            level = BxBlockCatalogue::VitaminValueService.new().saturated_fat_clc(saturate_fat, energy)
          end
        end
        return { saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated_fat', level) }
      else
        return { saturate_fat: checking_not_so_good_value(saturate_fat, 'saturated_fat', "N/A") }
      end
    end

    def product_sodium_level
      if ingredient.sodium.present?
        sodium = ingredient.sodium.to_f
        energy = ingredient.energy.to_f
        case product_type
        when 'solid'
          if sodium < 0.5
            level = "Free"
          elsif sodium >= 0.5 && sodium <= 5.0
            level = "Low"
          elsif sodium > 5.0
            level = BxBlockCatalogue::VitaminValueService.new().sodium_level_clc(sodium, energy)
          end
        when 'beverage'
          if sodium < 0.5
            level = "Free"
          elsif sodium >= 0.5 && sodium <= 2.5
            level = "Low"
          elsif sodium > 2.5
            level = BxBlockCatalogue::VitaminValueService.new().sodium_level_clc(sodium, energy)
            return { sodium: checking_not_so_good_value(sodium, 'sodium', level) }  
          end
        end
        return { sodium: checking_not_so_good_value(sodium, 'sodium', level) }  
      else
        return { sodium: checking_not_so_good_value(sodium, 'sodium', "N/A") }  
      end
    end

    def product_sugar_level
      if ingredient.total_sugar.present?
        energy = ingredient.energy.to_f
        sugar = ingredient.total_sugar.to_f
        pro_sugar_val = case product_type
        when 'solid'
          if sugar <= 0.5
            level = "Free"
          elsif sugar >= 0.5 && sugar <= 5.0
            level = "Low"
          elsif sugar > 5.0
            value = BxBlockCatalogue::VitaminValueService.new().suger_clc(product_type, sugar, energy)
          end
        when 'beverage'
          if sugar < 0.5
            level = "Free"
          elsif sugar >= 0.5 && sugar <= 2.5
            level = "Low"
          elsif sugar > 2.5
            level = BxBlockCatalogue::VitaminValueService.new().suger_clc(product_type, sugar, energy)
          end
        end
        return { sugar: checking_not_so_good_value(sugar, 'sugar', level) }
      else
        return { sugar: checking_not_so_good_value(sugar, 'sugar', "N/A") }
      end
    end

    def checking_not_so_good_value(ing_vlue, ing, level)
      level = "N/A" if level == nil
      return unless (not_so_good_value = NOT_SO_GOOD_INGREDIENTS[:"#{ing}"]).present?
      if ing_vlue != nil
       ing_vlue = ing_vlue.round(2)
        value_percent = ((ing_vlue / not_so_good_value[0]) * 100).round
      else
        value_percent = nil
        ing_vlue = 0.0
        level = "N/A"
      end
      [percent: value_percent, upper_limit: not_so_good_value[0], level: level, quantity: "#{ing_vlue} #{not_so_good_value[1]}", name: ing]
    end

		def calculation_for_rdas
      good_ingredient = []
      not_so_good_ingredient = []
      good_ingredient << vit_min_value
      good_ingredient << dietary_fibre
      good_ingredient << protein_value
      # not_so_good_ingredient << fat_value
      good_ingredient << trans_fat_value
      good_ingredient << cholesterol_value
      good_ingredient <<  product_sat_fat
      good_ingredient << product_sugar_level
      good_ingredient << product_sodium_level
      data = { good_ingredient: good_ingredient.flatten.compact }
    end

    def energy_from_saturated_fat
      saturate_fat = ingredient.saturate.to_f
      energy_from = saturate_fat * 9
      percent =  (energy_from / ingredient.energy.to_f) * 100
      value = if percent < 10
                 true
              else
                 false
              end
    end

	end
end