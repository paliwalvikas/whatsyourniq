# frozen_string_literal: true

module BxBlockCatalogue
  class NutritionalConsiderationService
    def check_nutrition(product, fav_id, data)
      val = FavouriteSearch.find_by(id: fav_id)&.health_preference
      result = {good_ingredient: [], not_so_good_ingredient: []}
      value = data_set(data)
      return unless fav_id.present?
      
      case val
      when 'Immunity'
        check_immunity(product, value, result)
      when 'Gut Health'
        check_gut_health(product, value, result)
      when 'Holistic Nutrition'
        check_holistic_nutrition(product, value, result)
      when 'Weight loss'
        check_weight_loss(product, value, result)
      when 'Weight gain'
        check_weight_gain(product, value, result)
      when 'Diabetic'
        check_diabetic(product, value, result)
      when 'Low Cholestrol'
        check_low_cholestrol(product, value, result)
      when 'Heart Friendly'
        check_heart_friendly(product, value, result)
      when 'Energy and Vitality'
        check_energy_and_vitality(product, value, result)
      when 'Physical growth'
        check_physical_growth(product, value, result)
      when 'Cognitive health'
        check_cognitive_health(product, value, result)
      when 'High Protein'
        check_high_protein(product, value, result)
      when 'Low Sugar'
        check_low_sugar(product, value, result)
      end
    end

    private

    def check_immunity(product, value, result)
      return unless product.health_preference.immunity

      high_immunonutrients(value, immunity_ing, result)
      final_result(value, %w[protein fibre], result)
    end

    def check_gut_health(product, value, result)
      final_result(value, ['fibre'], result) if product.health_preference.gut_health
    end

    def check_holistic_nutrition(product, value, result)
      return unless product.health_preference.holistic_nutrition

      high_immunonutrients(value, %w[vit_b12 vit_d iron], result)
      low_ing(value, %w[sugar sodium total_fat], result)
      final_result(value, %w[protein fibre], result)
    end

    def check_weight_loss(product, value, result)
      return unless product.health_preference.weight_loss

      high_immunonutrients(value, %w[vit_b1 vit_b2 vit_b6 vit_b12 vit_d iron], result)
      low_ing(value, ['calories'], result)
      final_result(value, %w[protein fibre], result)
    end

    def check_weight_gain(product, value, result)
      return unless product.health_preference.weight_gain

      high_immunonutrients(value, %w[vit_b1 vit_b2 vit_b6 vit_b12 vit_d iron], result)
      final_result(value, %w[calories protein fibre], result)
    end

    def check_diabetic(product, value, result)
      return unless product.health_preference.diabetic

      low_ing(value, ['sugar'], result)
      final_result(value, %w[protein fibre], result)
    end

    def check_low_cholestrol(product, value, result)
      low_ing(value, %w[saturated_fat cholesterol], result) if product.health_preference.low_cholesterol
    end

    def check_heart_friendly(product, value, result)
      return unless product.health_preference.heart_friendly

      low_ing(value, %w[saturated_fat cholesterol sugar], result)
      final_result(value, %w[fibre sugar], result)
    end

    def check_energy_and_vitality(product, value, result)
      return unless product.health_preference.energy_and_vitality

      high_immunonutrients(value, %w[vit_b1 vit_b2 vit_b6 vit_b12], result)
      final_result(value, %w[fibre protein], result)
    end

    def check_physical_growth(product, value, result)
      return unless product.health_preference.physical_growth

      high_immunonutrients(value, %w[calcium vit_d vit_b9 vit_b12 vit_b6 vit_b2], result)
      final_result(value, %w[fibre protein], result)
    end

    def check_cognitive_health(product, value, result)
      high_immunonutrients(value, %w[iron iodine vit_b12], result) if product.health_preference.cognitive_health
    end

    def check_high_protein(product, value, result)
      final_result(value, ['protein'], result) if product.health_preference.high_protein
    end

    def check_low_sugar(product, value, result)
      low_ing(value, ['sugar'], result) if product.health_preference.low_sugar
    end

    def data_set(data)
      val = []
      val << data[:good_ingredient]
      val << data[:not_so_good_ingredient]
      val.flatten! if val.present?
    end

    def final_result(value, ing, result)
      good_and_not_so_good(value, ing, result, 'High')
      result
    end

    def high_immunonutrients(value, ing, result)
      value&.each do |val|
        if ing.include?(val[:name]) && val[:level] == 'High'
          result[:good_ingredient] << { name: 'high_immunonutrients', level: 'High' }
          break
        end
      end
      result
    end

    def low_ing(value, ing, result)
      good_and_not_so_good(value, ing, result, 'Low')
      result
    end

    def good_and_not_so_good(value, ing, result, level)
      value&.each do |val|
        if not_good_ing.include?(val[:name])
          result[:not_so_good_ingredient] << val if ing.include?(val[:name]) && val[:level] == level
        else
          result[:good_ingredient] << val if ing.include?(val[:name]) && val[:level] == level
        end
      end
      result
    end

    def not_good_ing
      %w[calories total_fat saturated_fat cholesterol trans_fat sodium sugar]
    end

    def immunity_ing
      %w[vit_a vit_c vit_d iron vit_b6 vit_b12 vit_e zinc selenium copper]
    end
  end
end
