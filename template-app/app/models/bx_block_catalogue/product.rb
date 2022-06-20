module BxBlockCatalogue
  class Product < BxBlockCatalogue::ApplicationRecord
    self.table_name = :products
    enum product_type: [:cheese_and_oil, :beverage, :solid]
    validates :product_name, uniqueness: true
    has_one :ingredient, class_name: 'BxBlockCatalogue::Ingredient', dependent: :destroy
    has_one_attached :image
    belongs_to :category, class_name: 'BxBlockCategories::Category', dependent: :destroy, foreign_key: 'category_id'

    accepts_nested_attributes_for :ingredient, allow_destroy: true

    def calculation
      np = []
      pp = []
      unless self.product_point.present?
        ing = self.ingredient
        neg_clumns = BxBlockCatalogue::Ingredient.column_names - (BxBlockCheeseAndOil::MicroIngredient.column_names + BxBlockCheeseAndOil::PositiveIngredient.column_names + ['product_id'])

        neg_clumns.each do |clm|
          ing_value = ing.send(clm)
          np << check_value('negative_value', clm, ing_value) if ing_value.present?
        end  

        pos_clumns = BxBlockCatalogue::Ingredient.column_names - (BxBlockCheeseAndOil::MicroIngredient.column_names + BxBlockCheeseAndOil::NegativeIngredient.column_names + ['product_id'])

        pos_clumns.each do |clm|
          ing_value = ing.send(clm)
          pp << check_value('positive_value', clm, ing_value) if ing_value.present?
        end

        mp = micro_calculation(ing).sum

        p_point = np.sum - pp.sum 
        p_rating = if (p_point <= (-1))
          'A'
        elsif p_point.between?(0, 2)
          'B'
        elsif p_point.between?(3, 10)
          'C'
        elsif p_point.between?(11, 18)
          'D' 
        else 
          'E'
        end  
        self.update(product_rating: p_rating, product_point: p_point)  
      end 
      if self.product_rating.present?
        pr = if mp.to_f.between?(0,4)
          self.product_rating
        elsif mp.to_f.between?(4,8) && self.product_rating != 'A' && self.product_rating != 'E'
          (self.product_rating.ord - 1).chr
        elsif mp.to_f > (8) && self.product_rating != 'A' 
          (self.product_rating == 'D' || self.product_rating == 'E') ? (self.product_rating.ord - 1).chr : (self.product_rating.ord - 2).chr
        end
        self.update(product_rating: pr)
      end 
    end  

    def micro_calculation(ing)
      micro_clumns = BxBlockCatalogue::Ingredient.column_names - (BxBlockCheeseAndOil::PositiveIngredient.column_names + BxBlockCheeseAndOil::NegativeIngredient.column_names + ['product_id'])
      mm = []
      micro_clumns.each do |clm|
        ing_value = ing.send(clm)
        mm << check_value('micro_value',clm, ing_value) if ing_value.present? 
      end
      return mm   
    end   
    
    def check_value(val,ele,value)
      if self.product_type == 'cheese_and_oil' || self.product_type == 'solid'
        case val
        when 'negative_value'
          BxBlockCheeseAndOil::NegativeIngredient.all.each do |ni|
            neg_point = coding_calculation(ni, ele, value)
            return neg_point if neg_point.present?
          end  
        when 'positive_value'
          BxBlockCheeseAndOil::PositiveIngredient.all.each do |pi|
            pos_point = coding_calculation(pi, ele, value)
            return pos_point if pos_point.present?
          end       
        when 'micro_value'  
          BxBlockCheeseAndOil::MicroIngredient.all.each do |mi| 
            micro_point = coding_calculation(mi, ele, value)
            return micro_point if micro_point.present? 
          end   
        end 
      else self.product_type == 'beverage'
        case val
          when 'negative_value'
          BxBlockBeverage::BeverageNegativeIngredient.all.each do |ni|
            neg_point = coding_calculation(ni, ele, value)
            return neg_point if neg_point.present?
          end  
        when 'positive_value'
          BxBlockBeverage::BeveragePositiveIngredient.all.each do |pi|
            pos_point = coding_calculation(pi, ele, value)
            return pos_point if pos_point.present?
          end       
        when 'micro_value'  
          BxBlockBeverage::BeverageMicroIngredient.all.each do |mi| 
            micro_point = coding_calculation(mi, ele, value)
            return micro_point if micro_point.present? 
          end   
        end 
      end  
    end
    
    def coding_calculation(ing,ele,value)
      com_v = ing.send(ele)['value'].to_f
      com_lower = ing.send(ele)['lower_limit'].to_f
      com_upper = ing.send(ele)['upper_limit'].to_f
      case ing.send(ele)['sign']
      when 'less_than_equals_to'
        return ing.point if value.to_f <= com_v
      when 'greater_than_equals_to'
        return ing.point if value.to_f >= com_v
      when 'greater_than'
        return ing.point if value.to_f > com_v
      when 'less_than'
        return ing.point if value.to_f < com_v
      when 'in_between'
        return ing.point if value.to_f.between?(com_lower, com_upper) 
      end
    end  

    def protein_value 
      pro = self.ingredient.protein.to_f
      self.positive_good << case food_product_type
      when 'solid'
         (pro < 5.4) ? "low in protein" : ((pro >= 5.4 && pro < 10.8) ? "source in protein" : "high in protein")
          
      when 'beverage'   
        (pro < 2.7) ? "low in protein" : ((pro >= 2.7 && pro < 5.4) ? "source in protein" : "high in protein")           
      end  
    end  

    def vit_min_value
      ing = self.ingredient
      mp = micro_calculation(ing).sum
      if mp.present?
       self.positive_good << case food_product_type
        when 'solid'
            (mp < 0.6) ? "low in vit_min" : ((mp >= 0.6 && mp < 1.0) ? "source in vit_min" : "high in vit_min")

        when 'beverage'
            (mp < 0.6) ? "low in vit_min" : ((mp >= 0.6 && mp < 1.0) ? "source in vit_min" : "high in vit_min")
        end 
      end                                     
    end   

    def dietary_fibre
      pro = self.ingredient.fibre.to_f
      self.positive_good << case food_product_type
      when 'solid'
        (pro < 3.0) ? "low in fibre" : ((pro >= 3.0 && pro < 6.0) ? "source in fibre" : "high in fibre" )
      when 'beverage'  
        (pro < 1.5) ? "low in fibre" : ((pro >= 1.5 && pro < 3.0) ? "source in fibre" : "high in fibre" )
      end        
    end 

    def calories_energy
      pro = self.ingredient.energy.to_f
      self.negative_not_good << case food_product_type
      when 'solid'
        "low energy" if pro <= 40  
      when 'beverage'   
        if pro <= 4
          "free energy"
        elsif pro <= 20
          "low energy"
        end
      end  
    end   

    # def trans_fat
    #   energy = self.ingredient.energy.to_f
    #   trans_fat = self.ingredient.trans_fat.to_f
    #   case food_product_type
    #   when 'solid'
    #     if trans_fat < 0.2
    #       self.positive_good << "low trans_fat"
    #     elsif
    #       if energy.between?(0, 80)  && trans_fat > 0.09 || energy.between?(80, 160) && trans_fat > 0.18 || energy.between?(160, 240) && trans_fat > 0.27 || energy.between?(240, 320) && trans_fat > 0.36 || energy.between?(320, 400) && trans_fat > 0.44 ||  energy.between?(400, 480) && trans_fat > 0.53 ||energy.between?(480, 560) && trans_fat > 0.62 || energy.between?(560, 640) && trans_fat > 0.71 || energy.between?(640, 720) && trans_fat > 0.8 || energy.between?(720, 800) && trans_fat > 0.89 || energy > 800 && trans_fat > 0.89
    #         self.negative_not_good << "contains more than permissible trans fats"
    #       end   
    #     end 

      # when 'beverage'   
      #   if trans_fat < 0.5
      #      self.positive_good << "trans_fat free"
      #   elsif trans_fat >= 0.5 && trans_fat < 2.5
      #     self.positive_good << "low trans_fat"
      #   elsif 
      #     if energy > 0 && trans_fat > 0.09 || energy.between?(0, 7) && trans_fat > 0.18 || energy.between?(7, 14) && trans_fat > 0.27 || energy.between?(14, 22) && trans_fat > 0.36 || energy.between?(22, 29) && trans_fat > 0.44 || energy.between?(29, 36) && trans_fat > 0.53 || energy.between?(36, 43) && trans_fat > 0.62 || energy.between?(43, 50) && trans_fat > 0.71 || energy.between?(50, 57) && trans_fat > 0.8 || energy.between?(57, 64) && trans_fat > 0.89 
      #       self.negative_not_good << "High trans_fat"
      #     end
    #   #   end
    #   end    
    # end   

    # def product_sugar_level
    #   energy = self.ingredient.energy.to_f
    #   sugar = self.ingredient.total_sugar.to_f
    #   case food_product_type
    #   when 'solid'
    #     if sugar < 0.5
    #       self.positive_good << "Sugar free"
    #     elsif sugar >= 0.5 && sugar < 5.0
    #       self.positive_good << "low Sugar"
    #     elsif
    #       if energy.between?(0, 80)  && sugar > 4.5 || energy.between?(80, 160) && sugar > 9 || energy.between?(160, 240) && sugar > 13.5 || energy.between?(240, 320) && sugar > 18 || energy.between?(320, 400) && sugar > 22.5 ||  energy.between?(400, 480) && sugar > 27 ||energy.between?(480, 560) && sugar > 31 || energy.between?(560, 640) && sugar > 36 || energy.between?(640, 720) && sugar > 40 || energy.between?(720, 800) && sugar > 45
    #         self.negative_not_good << "High Sugar"
    #       end   
    #     end 
    #   when 'beverage'   
    #     if sugar < 0.5
    #        self.positive_good << "Sugar free"
    #     elsif sugar >= 0.5 && sugar < 2.5
    #       self.positive_good << "low Sugar"
    #     elsif 
    #       if energy > 0 && sugar > 0 || energy.between?(0, 7) && sugar > 1.5 || energy.between?(7, 14) && sugar > 3 || energy.between?(14, 22) && sugar > 4.5 || energy.between?(22, 29) && sugar > 6 || energy.between?(29, 36) && sugar > 7.5 || energy.between?(36, 43) && sugar > 9 || energy.between?(43, 50) && sugar > 10.5 || energy.between?(50, 57) && sugar > 12 || energy.between?(57, 64) && sugar > 13.5 
    #         self.negative_not_good << "High Sugar"
    #       end
    #     end
    #   end            
    # end  

    def product_sodium_level
      energy = self.ingredient.energy.to_f
      sodium = self.ingredient.sodium.to_f
      case food_product_type
      when 'solid'
        if sodium < 0.5
          self.positive_good << "sodium free"
        elsif sodium >= 0.5 && sodium < 5.0
          self.positive_good << "low sodium"
        elsif
          if energy.between?(0, 80)  && sodium > 90 || energy.between?(80, 160) && sodium > 180 || energy.between?(160, 240) && sodium > 270 || energy.between?(240, 320) && sodium > 360 || energy.between?(320, 400) && sodium > 450 ||  energy.between?(400, 480) && sodium > 540 || energy.between?(480, 560) && sodium > 630 || energy.between?(560, 640) && sodium > 720 || energy.between?(640, 720) && sodium > 810 || energy.between?(720, 800) && sodium > 900
            self.negative_not_good << "High sodium"
          end   
        end 
      when 'beverage'   
        if sodium < 0.5
           self.positive_good << "sodium free"
        elsif sodium >= 0.5 && sodium < 2.5
          self.positive_good << "low sodium"
        elsif 
          if energy > 0 && sodium > 90 || energy.between?(0, 7) && sodium > 180 || energy.between?(7, 14) && sodium > 270 || energy.between?(14, 22) && sodium > 360 || energy.between?(22, 29) && sodium > 450 || energy.between?(29, 36) && sodium > 540 || energy.between?(36, 43) && sodium > 630 || energy.between?(43, 50) && sodium > 720 || energy.between?(50, 57) && sodium > 810 || energy.between?(57, 64) && sodium > 900 
            self.negative_not_good << "High sodium"
          end
        end
      end  
    end   

    # def product_sat_fat
    #   saturate_fat = self.ingredient.saturate.to_f
    #   self.negative_not_good << case food_product_type
    #   when 'solid' 
    #     if saturate_fat <= 0.1
    #       "saturate_fat free"
    #     elsif saturate_fat > 0.1  && saturate_fat <= (1.5 + energy_from_saturated_fat)
    #        "low in saturate_fat"
    #     elsif saturate_fat >= 10.8
    #       "high saturate_fat" 
    #     end  
    #   when 'beverage'   
    #     if saturate_fat <= 0.1
    #       "saturate_fat free"
    #     elsif saturate_fat > 0.1   && saturate_fat <= (0.75 + energy_from_saturated_fat) 
    #       "low in saturate_fat"
    #     elsif saturate_fat >= 5.4
    #       "high saturate_fat"
    #     end
    #   end
    # end

    # def energy_from_saturated_fat
    #   saturate_fat = self.ingredient.saturate.to_f
    #   x = saturate_fat * 9
    #   sat_energy =  (x.to_f/self.ingredient.energy.to_f)*100
    #   if sat_energy <= 10
    #     return sat_energy
    #   end   
    # end   

    def food_product_type
      type = self.product_type
      type
    end    
  end   
end 
