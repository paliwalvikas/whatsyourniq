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
      mp = []
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

        micro_clumns = BxBlockCatalogue::Ingredient.column_names - (BxBlockCheeseAndOil::PositiveIngredient.column_names + BxBlockCheeseAndOil::NegativeIngredient.column_names + ['product_id'])
        micro_clumns.each do |clm|
          ing_value = ing.send(clm)
          mp << check_value('micro_value',clm, ing_value) if ing_value.present?  
        end
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
        pr = if mp.sum.between?(0,4)
          self.product_rating
        elsif mp.sum.between?(4,8) && self.product_rating != 'A' && self.product_rating != 'E'
          (self.product_rating.ord - 1).chr
        elsif mp.sum > (8) && self.product_rating != 'A' 
          (self.product_rating == 'D' || self.product_rating == 'E') ? (self.product_rating.ord - 1).chr : (self.product_rating.ord - 2).chr
        end
        self.update(product_rating: pr)
      end 
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

  
    # def fetch_image_data
    # byebug
    #   image_file = "https://rukminim1.flixcart.com/image/280/280/kobspe80/cookie-biscuit/d/d/p/kaju-kukkies-dukes-original-imag2thhbvzyfrpm.jpeg"
    #   BxBlockGoogleVision::ImageToTextService.new(file_name: image_file).convert
    # end  
  end
end 
