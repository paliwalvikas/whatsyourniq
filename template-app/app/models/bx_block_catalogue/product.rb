# frozen_string_literal: true

module BxBlockCatalogue
  class Product < BxBlockCatalogue::ApplicationRecord
    self.table_name = :products
    
    validates :bar_code , uniqueness: true
    validates :bar_code, presence: true

    GOOD_INGREDIENTS = { protein: [54, 'g'], fibre: [32, 'g'], vit_a: [1000, 'ug'], vit_c: [80, 'mg'], vit_d: [15, 'mcg'], iron: [19, 'mg'], calcium: [1000, 'mg'],
                         magnesium: [440, 'mg'], potassium: [3500, 'mg'], zinc: [17, 'mg'], iodine: [150, 'ug'], vit_b1: [1.4, 'mg'], vit_b2: [2.0, 'mg'], vit_b3: [1.4, 'mg'], vit_b6: [1.9, 'mg'], vit_b12: [2.2, 'ug'], vit_e: [10, 'mg'], vit_b7: [40, 'mcg'], vit_b5: [5, 'mg'], phosphorus: [1000, 'mg'], copper: [2, 'mg'], manganese: [4, 'mg'], chromium: [50, 'mca'], selenium: [40, 'mca'], chloride: [2050, 'mg'] }.freeze

    NOT_SO_GOOD_INGREDIENTS = { saturated_fat: [22, 'g'], sugar: [90, 'g'], sodium: [2000, 'mg'], calories: [0.0, 'kcal']}.freeze

    before_save :image_process, if: :image_url
    has_one_attached :image

    has_one :health_preference, class_name: 'BxBlockCatalogue::HealthPreference', dependent: :destroy

    has_one :ingredient, class_name: 'BxBlockCatalogue::Ingredient', dependent: :destroy
    has_many :order_items, class_name: 'BxBlockCatalogue::OrderItem', dependent: :destroy
    attr_accessor :image_url, :category_filter, :category_type_filter

    belongs_to :category, class_name: 'BxBlockCategories::Category', foreign_key: 'category_id'

    belongs_to :filter_category, class_name: 'BxBlockCategories::FilterCategory', foreign_key: 'filter_category_id'
    belongs_to :filter_sub_category, class_name: 'BxBlockCategories::FilterSubCategory', foreign_key: 'filter_sub_category_id'

    has_one :favourite_product, class_name: 'BxBlockCatalogue::FavouriteProduct', dependent: :destroy
    has_one :compare_product, class_name: 'BxBlockCatalogue::CompareProduct', dependent: :destroy

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

      unless product_point.present?
        ing = ingredient
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
        if p_point.zero? || np.blank? && pp.blank?
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
        end
      
      if product_rating.present?
        pr = if mp.to_f.between?(0, 4)
               product_rating
             elsif mp.to_f.between?(4, 8) && product_rating != 'A' && product_rating != 'E'
               (product_rating.ord - 1).chr
             elsif mp.to_f > (8) && product_rating != 'A'
               product_rating == 'D' || product_rating == 'E' ? (product_rating.ord - 1).chr : (product_rating.ord - 2).chr
             end
        self.product_rating = pr
      end
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
          protein_level =  'Low'
        elsif pro >= 5.4 && pro <= 10.8
          protein_level =  'Medium'
        elsif pro > 10.8
          protein_level =  'High'
        end
        data = checking_good_value(pro, 'protein', protein_level)
        value << checking_good_value(pro, 'protein', protein_level) 
      when 'beverage'
        if pro < 2.7
          protein_level =  'Low'
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
          vit_min_level = (val >= 0.6 && val < 1.0 ? 'Medium' : 'High')
          value = checking_good_value(mp, clm, vit_min_level)
          vit_min << value if value.present?
        end
      elsif self.product_type == "beverage" || self.product_type == "cheese_and_oil"
        micro_columns.each do |clm|
          good_value = GOOD_INGREDIENTS[:"#{clm}"]
          mp = ing.send(clm).to_f
          val = BxBlockCatalogue::VitaminValueService.new().set_vitamin_value_for_solid(clm, mp).to_f
          next if mp.zero? || good_value.nil?
          vit_min_level = (val >= 0.6 && val < 1.0 ? 'Medium' : 'High')
          value = checking_good_value(mp, clm, vit_min_level)
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
        elsif pro > 6.0
          'High'
        end
        value = checking_good_value(pro, 'fibre', fibre_level)
        fb << value if value.present? 
      when 'beverage'
        fibre_level = 'Low' if  pro < 1.5
        fibre_level = 'Medium' if pro >= 1.5 && pro < 3.0
        fibre_level = 'High' if pro > 3.0
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
      good_ingredient << vit_min_value 
      good_ingredient << dietary_fibre if dietary_fibre.present? && dietary_fibre.first[:level] != 'Low'
      good_ingredient << protein_value if protein_value.present? && protein_value.first[:level] != 'Low'
      good_ingredient << {Calories: calories_energy} if calories_energy.present?
      saturate_fat = product_sat_fat
      good_ingredient << saturate_fat[0] if saturate_fat&.last == true 
      not_so_good_ingredient << saturate_fat[0] if saturate_fat&.last == false 
      sugar = product_sugar_level
      good_ingredient << sugar[0] if sugar&.last == true 
      not_so_good_ingredient << sugar[0] if sugar&.last == false 
      sodium = product_sodium_level
      good_ingredient << sodium[0] if sodium&.last == true 
      not_so_good_ingredient << sodium[0] if sodium&.last == false 
      
      data = {
        good_ingredient: good_ingredient.flatten.compact,
        not_so_good_ingredient: not_so_good_ingredient.flatten
      }
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

      return checking_good_value(energy, 'calories', energy_level) if energy_level.present?
      []
    end

    # def trans_fat
    #   energy = ingredient.energy.to_f
    #   trans_fat = ingredient.trans_fat.to_f
    #   case product_type
    #   when 'solid'
    #     if trans_fat < 0.2
    #       positive_good << 'Low trans_fat'
    #     elsif if energy.between?(0,
    #                              80) && trans_fat > 0.09 || energy.between?(80,
    #                                                                         160) && trans_fat > 0.18 || energy.between?(160,
    #                                                                                                                     240) && trans_fat > 0.27 || energy.between?(240,
    #                                                                                                                                                                 320) && trans_fat > 0.36 || energy.between?(320,
    #                                                                                                                                                                                                             400) && trans_fat > 0.44 || energy.between?(400,
    #                                                                                                                                                                                                                                                         480) && trans_fat > 0.53 || energy.between?(480,
    #                                                                                                                                                                                                                                                                                                     560) && trans_fat > 0.62 || energy.between?(560,
    #                                                                                                                                                                                                                                                                                                                                                 640) && trans_fat > 0.71 || energy.between?(640,
    #                                                                                                                                                                                                                                                                                                                                                                                             720) && trans_fat > 0.8 || energy.between?(
    #                                                                                                                                                                                                                                                                                                                                                                                               720, 800
    #                                                                                                                                                                                                                                                                                                                                                                                             ) && trans_fat > 0.89 || energy > 800 && trans_fat > 0.89
    #             negative_not_good << 'contains more than permissible trans fats'
    #           end
    #     end

    #   when 'beverage'
    #     if trans_fat < 0.5
    #       positive_good << 'trans_fat Free'
    #     elsif trans_fat >= 0.5 && trans_fat < 2.5
    #       positive_good << 'Low trans_fat'
    #     elsif if energy.positive? && trans_fat > 0.09 || energy.between?(0,
    #                                                                      7) && trans_fat > 0.18 || energy.between?(7,
    #                                                                                                                14) && trans_fat > 0.27 || energy.between?(14,
    #                                                                                                                                                           22) && trans_fat > 0.36 || energy.between?(22,
    #                                                                                                                                                                                                      29) && trans_fat > 0.44 || energy.between?(29,
    #                                                                                                                                                                                                                                                 36) && trans_fat > 0.53 || energy.between?(36,
    #                                                                                                                                                                                                                                                                                            43) && trans_fat > 0.62 || energy.between?(43,
    #                                                                                                                                                                                                                                                                                                                                       50) && trans_fat > 0.71 || energy.between?(
    #                                                                                                                                                                                                                                                                                                                                         50, 57
    #                                                                                                                                                                                                                                                                                                                                       ) && trans_fat > 0.8 || energy.between?(
    #                                                                                                                                                                                                                                                                                                                                         57, 64
    #                                                                                                                                                                                                                                                                                                                                       ) && trans_fat > 0.89
    #             negative_not_good << 'High trans_fat'
    #           end
    #     end
    #   end
    # end

    def product_sugar_level
      energy = ingredient.energy.to_f
      sugar = ingredient.total_sugar.to_f
      return if sugar.zero?
      pro_sugar_val = case product_type
      when 'solid'
        if sugar < 0.5
          [checking_not_so_good_value(sugar, 'sugar', 'Free'), true]
        elsif sugar >= 0.5 && sugar < 5.0
          [checking_not_so_good_value(sugar, 'sugar', 'Low'), true]
        elsif energy.between?(0,80) && sugar > 4.5 || energy.between?(80,160) && sugar > 9 || energy.between?(160,240) && sugar > 13.5 || energy.between?(240,320) && sugar > 18 || energy.between?(320,400) && sugar > 22.5 || energy.between?(400,480) && sugar > 27 || energy.between?(480,560) && sugar > 31 || energy.between?(560,640) && sugar > 36 || energy.between?(640, 720) && sugar > 40 || energy.between?(720, 800) && sugar > 45
          [checking_not_so_good_value(sugar, 'sugar', 'High'), false]
        end
      when 'beverage'
        if sugar < 0.5
          [checking_not_so_good_value(sugar, 'sugar', 'Free'), true]
        elsif sugar >= 0.5 && sugar < 2.5
          [checking_not_so_good_value(sugar, 'sugar', 'Free'), true]
        elsif energy.positive? && sugar.positive? || energy.between?(0,7) && sugar > 1.5 || energy.between?(7,14) && sugar > 3 || energy.between?(14,22) && sugar > 4.5 || energy.between?(22,29) && sugar > 6 || energy.between?(29,36) && sugar > 7.5 || energy.between?(36,43) && sugar > 9 || energy.between?(43,50) && sugar > 10.5 || energy.between?(50, 57) && sugar > 12 || energy.between?(57, 64) && sugar > 13.5
          [checking_not_so_good_value(sugar, 'sugar', 'High'), false]

        end
      end
      pro_sugar_val || []
    end

    def nagetive_not_good_ing
      ['saturate', 'calories', 'sodium', 'sugar'] 
    end

    def product_sodium_level
      energy = ingredient.energy.to_f
      sodium = ingredient.sodium.to_f
      return [] if sodium.zero?
      case product_type
      when 'solid'
        if sodium < 0.5
          return [checking_not_so_good_value(sodium, 'sodium', 'Free'), true]
        elsif sodium >= 0.5 && sodium < 5.0
          return [checking_not_so_good_value(sodium, 'sodium', 'Low'), true]
        elsif energy.between?(0,80) && sodium > 90 || energy.between?(80,160) && sodium > 180 || energy.between?(160,240) && sodium > 270 || energy.between?(240,320) && sodium > 360 || energy.between?(320,400) && sodium > 450 || energy.between?(400,480) && sodium > 540 || energy.between?(480,560) && sodium > 630 || energy.between?(560,640) && sodium > 720 || energy.between?(640, 720) && sodium > 810 || energy.between?(720, 800) && sodium > 900
          return [checking_not_so_good_value(sodium, 'sodium', 'High'), false]
        end
      when 'beverage'
        if sodium < 0.5
          return [checking_not_so_good_value(sodium, 'sodium', 'Free'), true]
        elsif sodium >= 0.5 && sodium < 2.5
          return [checking_not_so_good_value(sodium, 'sodium', 'Low'), true]
        elsif energy.positive? && sodium > 90 || energy.between?(0,7) && sodium > 180 || energy.between?(7,14) && sodium > 270 || energy.between?(14,22) && sodium > 360 || energy.between?(22,29) && sodium > 450 || energy.between?(29,36) && sodium > 540 || energy.between?(36,43) && sodium > 630 || energy.between?(43,50) && sodium > 720 || energy.between?(50, 57) && sodium > 810 || energy.between?(57, 64) && sodium > 900
          return [checking_not_so_good_value(sodium, 'sodium', 'High'), false]
        end
      end
      []
    end

    def check_High_sodium(energy_range, _max_)
      energy.between?(energy_range) && sodium > max_sodium
    end


    def product_sat_fat
      saturate_fat = ingredient.saturate.to_f
      energy = ingredient.energy.to_f
      return if saturate_fat.zero?
      pro_sat_fat = case product_type
      when 'solid'
        if saturate_fat <= 0.1
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Free'), true]
        elsif saturate_fat > 0.1 && saturate_fat <= (1.5 + energy_from_saturated_fat)
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Low'), true]
        elsif saturate_fat.between?(1.5, 10) && energy.between?(0,800) || saturate_fat.between?(1, 10) && energy > 800
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'High'), false]
        end
      when 'beverage'
        if saturate_fat <= 0.1
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Free'), true]
        elsif saturate_fat > 0.1 && saturate_fat <= (0.75 + energy_from_saturated_fat)
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Low'), true]
        elsif saturate_fat.between?(0.76, 10) && energy.between?(0,800) || saturate_fat.between?(1, 10) && energy > 800
          return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'High'), false]
        end
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
  end
end