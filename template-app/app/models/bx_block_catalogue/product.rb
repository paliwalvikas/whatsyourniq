# frozen_string_literal: true

module BxBlockCatalogue
  class Product < BxBlockCatalogue::ApplicationRecord
    self.table_name = :products
    
    validates :bar_code , uniqueness: true
    validates :bar_code, presence: true

    GOOD_INGREDIENTS = { protein: [54, 'g'], fibre: [32, 'g'], vit_a: [1000, 'mcg'], vit_c: [80, 'mg'], vit_d: [15, 'mcg'], iron: [19, 'mg'], calcium: [1000, 'mg'],
                         magnesium: [440, 'mg'], potassium: [3500, 'mg'], zinc: [17, 'mg'], iodine: [150, 'ug'], vit_b1: [1.4, 'mg'], vit_b2: [2.0, 'mg'], vit_b3: [1.4, 'mg'], vit_b6: [1.9, 'mg'], vit_b12: [2.2, 'ug'], vit_e: [10, 'mcg'], vit_b7: [40, 'mcg'], vit_b5: [5, 'mg'], phosphorus: [1000, 'mg'], copper: [2, 'mg'], manganese: [4, 'mg'], chromium: [50, 'mca'], selenium: [40, 'mca'], chloride: [2050, 'mg'] }.freeze

    NOT_SO_GOOD_INGREDIENTS = { saturated_fat: [22, 'g'], sugar: [90, 'g'], sodium: [2000, 'mg'], calories: [2110, 'kcal']}.freeze
    attr_accessor :image_url, :category_filter, :category_type_filter

    # before_save :image_process, if: :image_url
    has_one_attached :image

    has_one :health_preference, class_name: 'BxBlockCatalogue::HealthPreference', dependent: :destroy

    has_one :ingredient, class_name: 'BxBlockCatalogue::Ingredient', dependent: :destroy
    has_many :order_items, class_name: 'BxBlockCatalogue::OrderItem', dependent: :destroy

    belongs_to :category, class_name: 'BxBlockCategories::Category', foreign_key: 'category_id'

    belongs_to :filter_category, class_name: 'BxBlockCategories::FilterCategory', foreign_key: 'filter_category_id'
    belongs_to :filter_sub_category, class_name: 'BxBlockCategories::FilterSubCategory', foreign_key: 'filter_sub_category_id'

    has_many :favourite_products, class_name: 'BxBlockCatalogue::FavouriteProduct', dependent: :destroy
    has_many :compare_products, class_name: 'BxBlockCatalogue::CompareProduct', dependent: :destroy

    enum product_type: %i[cheese_and_oil beverage solid]
    enum food_drink_filter: %i[food drink]

    accepts_nested_attributes_for :ingredient, allow_destroy: true
    after_create :product_health_preference
    scope :green, -> { where(data_check: 'green') }
    scope :red, -> { where(data_check: 'red') }
    scope :n_a, -> { where(data_check: 'na') }
    scope :n_c, -> { where(data_check: 'nc') }
    scope :product_type, ->(product_type) { where product_type: product_type }
    scope :product_rating, ->(product_rating) { where product_rating: product_rating }
    scope :food_drink_filter, ->(food_drink_filter) {where food_drink_filter: food_drink_filter}
    scope :filter_category_id, ->(filter_category_id) {where filter_category_id: filter_category_id}
    scope :filter_sub_category_id, ->(filter_sub_category_id) {where filter_sub_category_id: filter_sub_category_id}

    def product_health_preference
      unless self.health_preference.present?
        health = {"Immunity": nil ,"Gut Health": nil,"Holistic Nutrition": nil, "Weight loss": nil,"Weight gain": nil,"Diabetic": nil,"Low Cholesterol": nil,"Heart Friendly": nil,"Energy and Vitality": nil,"Physical growth": nil,"Cognitive health": nil,"High Protein": nil,"Low Sugar": nil}
        hsh = {}
        health.each do |key, value|
           value = BxBlockCatalogue::ProductHealthPreferenceService.new.health_preference(self, key.to_s)
           key = key.to_s.include?(' ') ? key.to_s.downcase.tr!(" ", "_") : key.to_s.downcase 
          hsh[key.to_sym] = value
        end 
        self.create_health_preference(immunity: hsh[:immunity], gut_health: hsh[:gut_health], holistic_nutrition: hsh[:holistic_nutrition],weight_loss: hsh[:weight_loss], weight_gain: hsh[:weight_gain], diabetic: hsh[:diabetic], low_cholesterol: hsh[:low_cholesterol], heart_friendly:hsh[:heart_friendly], energy_and_vitality: hsh[:energy_and_vitality],physical_growth: hsh[:physical_growth],cognitive_health: hsh[:cognitive_health],high_protein: hsh[:high_protein],low_sugar: hsh[:low_sugar])
      end
    end

    def product_type=(val)
      self[:product_type] = val&.downcase
    end

    def food_drink_filter=(val)
      self[:food_drink_filter] = val&.downcase
    end

    def data_check=(val)
      self[:data_check] = val&.downcase || 'NA'
    end

    def image_process
      begin
        file = open(image_url)
      rescue Errno::ENOENT, OpenURI::HTTPError, Errno::ENAMETOOLONG, Net::OpenTimeout, URI::InvalidURIError
        file = open('lib/image_not_found.jpeg')
      end
      image.attach(io: file, filename: 'some-image.jpg', content_type: 'image/jpg')
    end

    def calculation
      np = []
      pp = []
    # unless product_point.present?
      ing = ingredient
      neg_clumns = BxBlockCatalogue::Ingredient.column_names - (BxBlockCheeseAndOil::MicroIngredient.column_names + BxBlockCheeseAndOil::PositiveIngredient.column_names + ['product_id'])
      neg_clumns = neg_clumns.first(5)

      neg_clumns.each do |clm|
        ing_value = ing.send(clm)
        np << check_value('negative_value', clm, ing_value) if ing_value.present?
      end

      pos_clumns = BxBlockCatalogue::Ingredient.column_names - (BxBlockCheeseAndOil::MicroIngredient.column_names + BxBlockCheeseAndOil::NegativeIngredient.column_names + ['product_id'])
      if np.sum >= 11 && self.ingredient.fruit_veg.to_i < 5 
        pos_clumns = pos_clumns.first(2)
      else
        pos_clumns.first(3)
      end

      pos_clumns.each do |clm|
        ing_value = ing.send(clm)
        pp << check_value('positive_value', clm, ing_value) if ing_value.present?
      end
      mp = micro_calculation(ing).sum
      p_point = np.sum - pp.sum
      if np.blank? && pp.blank?
        self.product_rating = nil
        self.product_point = nil
      else
        p_rating = if p_point <= (-1)
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
          self.product_rating = p_rating
          self.product_point = p_point
      end
    # end
      
      if product_rating.present?
        pr = if mp.to_f.between?(0, 4)
               product_rating
             elsif mp.to_f.between?(4, 8) && product_rating != 'A' && product_rating != 'E'
               (product_rating.ord - 1).chr
             elsif mp.to_f > (8) && product_rating != 'A'
               product_rating == 'D' || product_rating == 'E' ? (product_rating.ord - 1).chr : (product_rating.ord - 2).chr
             elsif mp.to_f > (8) && product_rating == 'A'
                pr = "A"
             end
          if pr == "@" || pr == "?" 
            pr = "A"
          end
        self.product_rating = pr
      end
      self.calculated = true
      self.save!
    end

    def micro_calculation(ing)
      point = []
      micro_columns.each do |clm|
        ing_value = ing.send(clm)
        point << check_value('micro_value', clm, ing_value) if ing_value.present?
      end
      point
    end

    def micro_columns
      micro_columns = BxBlockCatalogue::Ingredient.column_names - (BxBlockCheeseAndOil::PositiveIngredient.column_names + BxBlockCheeseAndOil::NegativeIngredient.column_names + ['product_id'])
    end

    def check_value(val, ele, value)
      if product_type == 'cheese_and_oil' || product_type == 'solid'
        case val
        when 'negative_value'
          BxBlockCheeseAndOil::NegativeIngredient.all.each do |ni|
            neg_point = coding_calculation(ni, ele, value)
            return neg_point if neg_point.present?
          end
          0
        when 'positive_value'
          BxBlockCheeseAndOil::PositiveIngredient.all.each do |pi|
            pos_point = coding_calculation(pi, ele, value)
            return pos_point if pos_point.present?
          end
          0
        when 'micro_value'
          BxBlockCheeseAndOil::MicroIngredient.all.each do |mi|
            micro_point = coding_calculation(mi, ele, value)
            return micro_point if micro_point.present?
          end
          0
        end
      else
        product_type == 'beverage'
        case val
        when 'negative_value'
          BxBlockBeverage::BeverageNegativeIngredient.all.each do |ni|
            neg_point = coding_calculation(ni, ele, value)
            return neg_point if neg_point.present?
          end
          0
        when 'positive_value'
          BxBlockBeverage::BeveragePositiveIngredient.all.each do |pi|
            pos_point = coding_calculation(pi, ele, value)
            return pos_point if pos_point.present?
          end
          0
        when 'micro_value'

          BxBlockBeverage::BeverageMicroIngredient.all.each do |mi|
            micro_point = coding_calculation(mi, ele, value)
            return micro_point if micro_point.present? 
          end
          0
        end
      end
    end

    def coding_calculation(ing, ele, value)
      return 0 if %w[carbohydrate cholestrol soyabean wheat peanuts tree_nuts shellfish total_fat
            monosaturated_fat polyunsaturated_fat fatty_acid mono_unsaturated_fat veg_and_nonveg gluteen_free added_sugar artificial_preservative organic vegan_product egg fish trans_fat].include?(ele) || ing.send(ele).nil?

      com_v = ing.send(ele)['value'].to_f
      com_lower = ing.send(ele)['lower_limit'].to_f
      com_upper = ing.send(ele)['upper_limit'].to_f
      point = case ing.send(ele)['sign']
      when 'less_than_equals_to'
        ing.point if value.to_f <= com_v
      when 'greater_than_equals_to'
        ing.point if value.to_f >= com_v
      when 'greater_than'
        ing.point if value.to_f > com_v
      when 'less_than'
        ing.point if value.to_f < com_v
      when 'in_between'
        ing.point if value.to_f.between?(com_lower, com_upper)
      end
      point
    end

    def protein_value
      return [] if ingredient.protein.nil? 
      pro = ingredient.protein.to_f
      value = []
      case product_type
      when 'solid'
        if pro < 5.4
          protein_level = 'Low'
        elsif pro >= 5.4 && pro < 10.8
          protein_level = 'Medium'
        elsif pro >= 10.8
          protein_level = 'High'
        end
        data = checking_good_value(pro, 'protein', protein_level)
        value << checking_good_value(pro, 'protein', protein_level) 
      when 'beverage'
        if pro < 2.7
          protein_level = 'Low'
        elsif pro >= 2.7 && pro < 5.4
          protein_level =  'Medium'
        elsif pro >= 5.4
          protein_level = 'High'
        end
        data = checking_good_value(pro, 'protein', protein_level)
        value << checking_good_value(pro, 'protein', protein_level) 
      end
    end

    def vit_min_value 
      ing = ingredient
      vit_min = []
      val = 0
      if self.product_type == "solid"
        micro_columns.each do |clm|
          good_value = GOOD_INGREDIENTS[:"#{clm}"]
          mp = ing.send(clm).to_f
          val = BxBlockCatalogue::VitaminValueService.new().set_vitamin_value_for_solid(clm, mp).to_f
          next if mp.zero? || good_value.nil?
          if val <= 0.5 
            vit_min_level = 'Low'
          elsif val >= 0.6 && val < 1
            vit_min_level = 'Medium'
          elsif val >= 1
            vit_min_level = 'High'
          end
          value = checking_good_value(mp, clm, vit_min_level) if  vit_min_level != 'Low'
          vit_min << value if value.present?
        end
      elsif self.product_type == "beverage" || self.product_type == "cheese_and_oil"
        micro_columns.each do |clm|
          good_value = GOOD_INGREDIENTS[:"#{clm}"]
          mp = ing.send(clm).to_f
          val = BxBlockCatalogue::VitaminValueService.new().set_vitamin_value_for_beaverage(clm, mp).to_f
          next if mp.zero? || good_value.nil?
          if val <= 0.5 
            vit_min_level = 'Low'
          elsif val >= 0.6 && val < 1
            vit_min_level = 'Medium'
          elsif val >= 1
            vit_min_level = 'High'
          end
          value = checking_good_value(mp, clm, vit_min_level) if  vit_min_level != 'Low'
          vit_min << value if value.present?
        end
      end
      vit_min
    end

    def levels_for_vit_and_min(columns)
      ing = ingredient
      vit_min = []
      columns.each do |clm|
        ing_value = ing.send(clm)
        next unless ing_value.present?
        ing_value = ing_value.to_f
        vit_min << check_value('micro_value', clm, ing_value) if ing_value.present?
      end
      sum_of_vit_and_min = vit_min.sum.to_f
      level = if (sum_of_vit_and_min < 0.6)
                "Low"
              else
                (sum_of_vit_and_min >= 0.6 && sum_of_vit_and_min < 1.0 ? "Medium" : "High")
              end
      level
    end

    def minral_columns
      ['calcium', 'iron', 'magnesium', 'zinc', 'iodine', 'potassium', 'phosphorus', 'manganese', 'copper', 'selenium', 'chloride', 'chromium']
    end

    def vitamin_columns
      ['vit_a','vit_c','vit_d','vit_b6','vit_b12','vit_b9','vit_b2','vit_b3','vit_b1','vit_b5','vit_b7']
    end

    def dietary_fibre
      return unless ingredient.fibre.present?
      pro = ingredient.fibre.to_f
      fb = []
      case product_type
      when 'solid'
      fibre_level = if pro < 3.0
          'Low'
        elsif pro >= 3.0 && pro < 6.0
          'Medium'
        elsif pro >= 6.0
          'High'
        end
        value = checking_good_value(pro, 'fibre', fibre_level)
        fb << value if value.present? 
      when 'beverage'
        fibre_level = 'Low' if  pro < 1.5
        fibre_level = 'Medium' if pro >= 1.5 && pro < 3.0
        fibre_level = 'High' if pro >= 3.0
        value = checking_good_value(pro, 'fibre', fibre_level)
        fb << value if value.present?
      end
      fb
    end

    def checking_good_value(ing_vlue, ing, level)
      return unless (good_value = GOOD_INGREDIENTS[:"#{ing}"]).present?
      value_percent = ((ing_vlue / good_value[0]) * 100).round
      { percent: value_percent, upper_limit: good_value[0], level: level, quantity: "#{ing_vlue.round(2)} #{good_value[1]}", name: ing }
    end

    def checking_not_so_good_value(ing_vlue, ing, level)
      return unless (not_so_good_value = NOT_SO_GOOD_INGREDIENTS[:"#{ing}"]).present?
      value_percent = ((ing_vlue / not_so_good_value[0]) * 100).round
      [percent: value_percent, upper_limit: not_so_good_value[0], level: level, quantity: "#{ing_vlue.round(2)} #{not_so_good_value[1]}", name: ing]
    end

    def rda_calculation
      good_ingredient = []
      not_so_good_ingredient = []
      good_ingredient << protein_value if protein_value.present? && protein_value.first[:level] != 'Low'
      good_ingredient << dietary_fibre if dietary_fibre.present? && dietary_fibre.first[:level] != 'Low'
      good_ingredient << vit_min_value 
      good_ingredient << calories_energy if calories_energy.present?
      saturate_fat = product_sat_fat
      if saturate_fat != nil && saturate_fat != [] && saturate_fat.first.first[:level] != nil
        good_ingredient << saturate_fat[0] if saturate_fat&.last == true 
        not_so_good_ingredient << saturate_fat[0] if saturate_fat&.last == false 
      end
      sugar = product_sugar_level
      if sugar != nil && sugar != [] && sugar.first.first[:level] != nil
        good_ingredient << sugar[0] if sugar&.last == true 
        not_so_good_ingredient << sugar[0] if sugar&.last == false 
      end
      sodium = product_sodium_level
      if sodium != nil && sodium != [] && sodium.first.first[:level] != nil
        good_ingredient << sodium[0] if sodium&.last == true 
        not_so_good_ingredient << sodium[0] if sodium&.last == false 
      end
      data = {
        good_ingredient: good_ingredient.flatten.compact,
        not_so_good_ingredient: not_so_good_ingredient.flatten
      }
    end

    def negative_and_positive
      p_good, neg_n_good = [], []
      p_good << vit_min_value 
      p_good << dietary_fibre if dietary_fibre.present? && dietary_fibre.first[:level] != 'Low'
      p_good << protein_value if protein_value.present? && protein_value.first[:level] != 'Low'
      neg_n_good << {Calories: calories_energy} if calories_energy.present?
      saturate_fat = product_sat_fat
      neg_n_good << saturate_fat[0] if saturate_fat&.last == false || saturate_fat&.last == true
      sugar = product_sugar_level
      # p_good << saturate_fat[0] if saturate_fat&.last == true 
      # p_good << sugar[0] if sugar&.last == true 
      # p_good << sodium[0] if sodium&.last == true 
      neg_n_good << sugar[0] if sugar&.last == false || sugar&.last == true
      sodium = product_sodium_level
      p_good << probiotic_value
      neg_n_good << sodium[0] if sodium&.last == false || sodium&.last == true 
      neg_n_good << cholesterol_value 
      neg_n_good << fat_value
      neg_n_good << trans_fat_value
      self.negative_not_good = neg_n_good.flatten.compact if neg_n_good.present?
      self.positive_good = p_good.flatten.compact if p_good.present?
      self.np_calculated = true
      self.save!
    end

    def probiotic_value
      return unless ingredient.probiotic.present?
      pro = ingredient.probiotic.to_f
      level = if pro < 10**8  
          'Low'
        elsif pro > 10**8  
          'Medium'
        end
      value = [level: level, name: "probiotic"] if level.present?
    end

    def cholesterol_value
      return unless ingredient.cholestrol.present?
      pro = ingredient.cholestrol.to_f
      sat_fat = ingredient.saturate.to_f
      fb = []
      case product_type
      when 'solid'
      cho_level = if pro < 5 && sat_fat < 1.5 && energy_from_saturated_fat 
          'Free'
        elsif pro < 20 && sat_fat < 1.5 && energy_from_saturated_fat
          'Low'
        end
        value = [level: cho_level, name: "Cholesterol"] if cho_level.present? 
      when 'beverage'
        cho_level = 'Free' if  pro < 5 && sat_fat < 0.75 && energy_from_saturated_fat 
        cho_level = 'Low' if  pro < 10 && sat_fat < 0.75 && energy_from_saturated_fat
        value = [level: cho_level, name: "Cholesterol"] if cho_level.present?
      end
      value
    end

    def compare_product_good_not_so_good
      BxBlockCatalogue::ProductService.new(ingredient, product_type).calculation_for_rdas
    end

    def vitamins_and_minrals
      good_ingredient = { vitamins: [percent: 0.0, upper_limit: 0.0, level: levels_for_vit_and_min(vitamin_columns), quantity: 0.0],
        minerals: [percent: 0.0, upper_limit: 0.0, level: levels_for_vit_and_min(minral_columns), quantity: 0.0]}
    end

    def calories_energy
      return unless (energy = ingredient.energy).present?
      energy = energy.to_f
      energy_level = case product_type
             when 'solid'
               'Low' if energy <= 40
             when 'beverage'
               if energy <= 4
                 'Free'
               elsif energy <= 20
                 'Low'
               end
             end
    return [ checking_not_so_good_value(energy, 'calories', energy_level )] if energy_level.present?
    end

    def fat_value
      return unless ingredient.fat.present?
      pro = ingredient.fat.to_f
      fb = []
      case product_type
      when 'solid'
      fat_level = if pro < 0.5 
          'Free'
        elsif pro < 3
          'Low'
        end
        value = [level: fat_level, name: "Fat"] if fat_level.present? 
      when 'beverage'
        fat_level = 'Free' if  pro < 0.5 
        fat_level = 'Low' if  pro < 1.5
        value = [level: fat_level, name: "Fat"] if fat_level.present?
      end
      value
    end

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

    # def trans_fat
    #   energy = ingredient.energy.to_f
    #   trans_fat = ingredient.trans_fat.to_f
    #   case product_type
    #   when 'solid'
    #     if trans_fat < 0.2
    #       positive_good << 'Low trans_fat'
    #     elsif if energy.between?(0,80) && trans_fat > 0.09 || energy.between?(80,160) && trans_fat > 0.18 || energy.between?(160,240) && trans_fat > 0.27 || energy.between?(240,320) && trans_fat > 0.36 || energy.between?(320,400) && trans_fat > 0.44 || energy.between?(400,480) && trans_fat > 0.53 || energy.between?(480,560) && trans_fat > 0.62 || energy.between?(560,640) && trans_fat > 0.71 || energy.between?(640,720) && trans_fat > 0.8 || energy.between?(720, 800) && trans_fat > 0.89 || energy > 800 && trans_fat > 0.89negative_not_good << 'contains more than permissible trans fats'
    #           end
    #     end

    #   when 'beverage'
    #     if trans_fat < 0.5
    #       positive_good << 'trans_fat Free'
    #     elsif trans_fat >= 0.5 && trans_fat < 2.5
    #       positive_good << 'Low trans_fat'
    #     elsif if energy.positive? && trans_fat > 0.09 || energy.between?(0,7) && trans_fat > 0.18 || energy.between?(7,14) && trans_fat > 0.27 || energy.between?(14,22) && trans_fat > 0.36 || energy.between?(22,29) && trans_fat > 0.44 || energy.between?(29,36) && trans_fat > 0.53 || energy.between?(36,43) && trans_fat > 0.62 || energy.between?(43,50) && trans_fat > 0.71 || energy.between?(50, 57) && trans_fat > 0.8 || energy.between?(57, 64) && trans_fat > 0.89
    #             negative_not_good << 'High trans_fat'
    #           end
    #     end
    #   end
    # end

    def product_sugar_level
      return if ingredient.total_sugar.nil?
      energy = ingredient.energy.to_f
      sugar = ingredient.total_sugar.to_f
      pro_sugar_val = case product_type
      when 'solid'
        if sugar <= 0.5
          [checking_not_so_good_value(sugar, 'sugar', 'Free'), true]
        elsif sugar >= 0.5 && sugar <= 5.0
          [checking_not_so_good_value(sugar, 'sugar', 'Low'), true]
        elsif sugar > 5.0
          value = BxBlockCatalogue::VitaminValueService.new().suger_clc(product_type, sugar, energy)
          [checking_not_so_good_value(sugar, 'sugar', value), false] 
        end
      when 'beverage'
        if sugar < 0.5
          [checking_not_so_good_value(sugar, 'sugar', 'Free'), true]
        elsif sugar >= 0.5 && sugar <= 2.5
          [checking_not_so_good_value(sugar, 'sugar', 'Low'), true]
        elsif sugar > 2.5
          value = BxBlockCatalogue::VitaminValueService.new().suger_clc(product_type, sugar, energy)
          [checking_not_so_good_value(sugar, 'sugar', value), false] 
        end
      end
      pro_sugar_val || []
    end

    def nagetive_not_good_ing
      ['saturate', 'calories', 'sodium', 'sugar'] 
    end

    def product_sodium_level
      energy = ingredient.energy.to_f
      return [] if ingredient.sodium.nil?
      sodium = ingredient.sodium.to_f
      case product_type
      when 'solid'
        if sodium < 0.5
          return [checking_not_so_good_value(sodium, 'sodium', 'Free'), true]
        elsif sodium >= 0.5 && sodium <= 5.0
          return [checking_not_so_good_value(sodium, 'sodium', 'Low'), true]
        elsif sodium > 5.0
          value = BxBlockCatalogue::VitaminValueService.new().sodium_level_clc(sodium, energy)
          return [checking_not_so_good_value(sodium, 'sodium', value), false]  
        end
      when 'beverage'
        if sodium < 0.5
          return [checking_not_so_good_value(sodium, 'sodium', 'Free'), true]
        elsif sodium >= 0.5 && sodium <= 2.5
          return [checking_not_so_good_value(sodium, 'sodium', 'Low'), true]
        elsif sodium > 2.5
          value = BxBlockCatalogue::VitaminValueService.new().sodium_level_clc(sodium, energy)
          return [checking_not_so_good_value(sodium, 'sodium', value), false]  
        end
      end
      []
    end

    def check_High_sodium(energy_range, _max_)
      energy.between?(energy_range) && sodium > max_sodium
    end

    def product_sat_fat
      return if ingredient.saturate.nil?
      saturate_fat = ingredient.saturate.to_f
      energy = ingredient.energy.to_f
      pro_sat_fat = case product_type
      when 'solid'
        if saturate_fat <= 0.1
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Free'), true]
        elsif saturate_fat > 0.1 && saturate_fat <= 1.5 && energy_from_saturated_fat
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Low'), true]
        elsif saturate_fat >= 1.5 || energy_from_saturated_fat 
          value = BxBlockCatalogue::VitaminValueService.new().saturated_fat_clc(saturate_fat, energy)
          rating = value == 'High' ? false : true 
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', value), rating] 
        end
      when 'beverage'
        if saturate_fat <= 0.1
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Free'), true]
        elsif saturate_fat > 0.1 && saturate_fat <= 0.75 && energy_from_saturated_fat
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Low'), true]
        elsif saturate_fat >= 2 || energy_from_saturated_fat
          value = BxBlockCatalogue::VitaminValueService.new().saturated_fat_clc(saturate_fat, energy)
          rating = value == 'High' ? false : true 
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', value), rating] 
        end
      end
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