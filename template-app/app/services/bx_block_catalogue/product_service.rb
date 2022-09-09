module BxBlockCatalogue
	class ProductService

		attr_accessor :ingredient, :product_type

		 GOOD_INGREDIENTS = { protein: [54, 'g'], fibre: [32, 'g'], vit_a: [1000, 'ug'], vit_c: [80, 'mg'], vit_d: [15, 'iu'], iron: [19, 'mg'], calcium: [1000, 'mg'],
                         magnesium: [440, 'mg'], potassium: [3500, 'mg'], zinc: [17, 'mg'], iodine: [150, 'ug'], vit_b1: [1.4, 'mg'], vit_b2: [2.0, 'mg'], vit_b3: [1.4, 'mg'], vit_b6: [1.9, 'mg'], vit_b12: [2.2, 'ug'], vit_e: [10, 'mg'], vit_b7: [40, 'mcg'], vit_b5: [5, 'mg'], phosphorus: [1000, 'mg'], copper: [2, 'mg'], manganese: [4, 'mg'], chromium: [50, 'mca'], selenium: [40, 'mca'], chloride: [2050, 'mg'] }.freeze

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
        unless mp.zero?
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
	         fibre_level  = 'low'
	        elsif pro >= 3.0 && pro < 6.0
	        	fibre_level = 'medium'
	        elsif pro >= 6.0
	        	fibre_level ='high'
	        end
	        fb << { Fibre: checking_good_value(pro, 'fibre', fibre_level)}
	      when 'beverage'
	        if pro < 1.5
	         fibre_level  = 'low'
	        elsif pro >= 1.5 && pro < 3.0
	        	fibre_level = 'medium'
	        elsif pro >= 3.0
	        	fibre_level ='high'
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

    def checking_good_value(ing_vlue, ing, level)
    	GOOD_INGREDIENTS[:"#{ing}"] == nil || GOOD_INGREDIENTS[:"#{ing}"] == "N/A" ? good_value = 0 :  good_value = GOOD_INGREDIENTS[:"#{ing}"]
    	ing_vlue == nil || ing_vlue == "N/A" ? ing_vlue = 0 : ing_vlue
      if good_value.present?
        value_percent = ((ing_vlue / good_value[0]) * 100).round if good_value[0] > 0
        [percent: value_percent, upper_limit: good_value[0], level: level, quantity: "#{ing_vlue.round(2)} #{good_value[1]}"]
      end
    end

		def calculation_for_rdas
      good_ingredient = []
      good_ingredient << vit_min_value
      good_ingredient << dietary_fibre
      good_ingredient << protein_value
      data = { good_ingredient: good_ingredient.flatten.compact }
    end

	end

end