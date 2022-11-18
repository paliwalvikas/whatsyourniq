# frozen_string_literal: true

class CalculateRda
  GOOD_INGREDIENTS = { protein: [54, 'g'], fibre: [32, 'g'], vit_a: [1000, 'mcg'], vit_c: [80, 'mg'], vit_d: [15, 'mcg'], iron: [19, 'mg'], calcium: [1000, 'mg'],
                       magnesium: [440, 'mg'], potassium: [3500, 'mg'], zinc: [17, 'mg'], iodine: [150, 'ug'], vit_b1: [1.4, 'mg'], vit_b2: [2.0, 'mg'], vit_b3: [1.4, 'mg'], vit_b6: [1.9, 'mg'], vit_b12: [2.2, 'ug'], vit_e: [10, 'mcg'], vit_b7: [40, 'mcg'], vit_b9: [40, 'mcg'], vit_b5: [5, 'mg'], phosphorus: [1000, 'mg'], copper: [2, 'mg'], manganese: [4, 'mg'], chromium: [50, 'mca'], selenium: [40, 'mca'], chloride: [2050, 'mg'] }.freeze

  NOT_SO_GOOD_INGREDIENTS = { saturated_fat: [22, 'g'], sugar: [90, 'g'], sodium: [2000, 'mg'],
                              calories: [2110, 'kcal'], cholesterol: [300, 'mg'], trans_fat: [2, 'g'], total_fat: [67, 'g'] }.freeze

  def rda_calculation(product)
    @product = product
    good_ingredient = []
    not_so_good_ingredient = []
    good_ingredient << protein_value if protein_value.present? && protein_value.first[:level] != 'Low'
    good_ingredient << dietary_fibre if dietary_fibre.present? && dietary_fibre.first[:level] != 'Low'
    good_ingredient << vit_min_value(true, "a")
    good_ingredient << calories_energy if calories_energy.present?
    saturate_fat = product_sat_fat
    if !saturate_fat.nil? && saturate_fat != [] && !saturate_fat.first.first[:level].nil?
      good_ingredient << saturate_fat[0] if saturate_fat&.last == true
      not_so_good_ingredient << saturate_fat[0] if saturate_fat&.last == false
    end
    sugar = product_sugar_level
    if !sugar.nil? && sugar != [] && !sugar.first.first[:level].nil?
      good_ingredient << sugar[0] if sugar&.last == true
      not_so_good_ingredient << sugar[0] if sugar&.last == false
    end
    sodium = product_sodium_level
    if !sodium.nil? && sodium != [] && !sodium.first.first[:level].nil?
      good_ingredient << sodium[0] if sodium&.last == true
      not_so_good_ingredient << sodium[0] if sodium&.last == false
    end
    cholestrol = cholesterol_rda
    if !cholestrol.nil? && cholestrol != [] && !cholestrol.first.first[:level].nil?
      good_ingredient << cholestrol[0] if cholestrol&.last == true
      not_so_good_ingredient << cholestrol[0] if cholestrol&.last == false
    end
    trans_fat = trans_fat_rda
    if !trans_fat.nil? && trans_fat != [] && !trans_fat.first.first[:level].nil?
      good_ingredient << trans_fat[0] if trans_fat&.last == true
      not_so_good_ingredient << trans_fat[0] if trans_fat&.last == false
    end
    total_fat = total_fat_rda
    if !total_fat.nil? && total_fat != [] && !total_fat.first.first[:level].nil?
      good_ingredient << total_fat[0] if total_fat&.last == true
      not_so_good_ingredient << total_fat[0] if total_fat&.last == false
    end
    data = {
      good_ingredient: good_ingredient.flatten.compact,
      not_so_good_ingredient: not_so_good_ingredient.flatten
    }
  end

  def protein_value
    return [] if @product.ingredient.protein.nil?

    pro = @product.ingredient.protein.to_f
    value = []
    case @product.product_type
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
        protein_level = 'Medium'
      elsif pro >= 5.4
        protein_level = 'High'
      end
      data = checking_good_value(pro, 'protein', protein_level)
      value << checking_good_value(pro, 'protein', protein_level)
    end
  end

  def vit_min_value(value, var)
    ing = @product.ingredient
    vit_min = []
    val = 0
    case @product.product_type
    when 'solid'
      CalculateProductRating.new.micro_columns.each do |clm|
        good_value = GOOD_INGREDIENTS[:"#{clm}"]
        mp = ing.send(clm).to_f
        val = BxBlockCatalogue::VitaminValueService.new.set_vitamin_value_for_solid(clm, mp).to_f
        next if mp.zero? || good_value.nil?

        if val <= 0.5
          vit_min_level = 'Low'
        elsif val >= 0.6 && val < 1
          vit_min_level = 'Medium'
        elsif val >= 1
          vit_min_level = 'High'
        end
        value = checking_good_value(mp, clm, vit_min_level) if vit_min_level != 'Low' || var == "vit"
        vit_min << value if value.present?
      end
    when 'beverage', 'cheese_and_oil'
      CalculateProductRating.new.micro_columns.each do |clm|
        good_value = GOOD_INGREDIENTS[:"#{clm}"]
        mp = ing.send(clm).to_f
        val = BxBlockCatalogue::VitaminValueService.new.set_vitamin_value_for_beaverage(clm, mp).to_f
        next if mp.zero? || good_value.nil?

        if val <= 0.5
          vit_min_level = 'Low'
        elsif val >= 0.6 && val < 1
          vit_min_level = 'Medium'
        elsif val >= 1
          vit_min_level = 'High'
        end
        if value
          value = checking_good_value(mp, clm, vit_min_level) if vit_min_level != 'Low' || var == "vit"
          vit_min << value if value.present?
        else
          value = checking_good_value(mp, clm, vit_min_level)
          vit_min << value if value.present?
        end
      end
    end
    vit_min
  end

  def levels_for_vit_and_min(columns)
    ing = @product.ingredient
    vit_min = []
    columns.each do |clm|
      ing_value = ing.send(clm)
      next unless ing_value.present?

      ing_value = ing_value.to_f
      vit_min << check_value('micro_value', clm, ing_value) if ing_value.present?
    end
    sum_of_vit_and_min = vit_min.sum.to_f
    if sum_of_vit_and_min < 0.6
      'Low'
    else
      (sum_of_vit_and_min >= 0.6 && sum_of_vit_and_min < 1.0 ? 'Medium' : 'High')
    end
  end

  # def minral_columns
  #   %w[calcium iron magnesium zinc iodine potassium phosphorus manganese copper selenium
  #      chloride chromium]
  # end

  # def vitamin_columns
  #   %w[vit_a vit_c vit_d vit_b6 vit_b12 vit_b9 vit_b2 vit_b3 vit_b1 vit_b5 vit_b7]
  # end

  def dietary_fibre
    return unless @product.ingredient.fibre.present?

    pro = @product.ingredient.fibre.to_f
    fb = []
    case @product.product_type
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
      fibre_level = 'Low' if pro < 1.5
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
    { percent: value_percent, upper_limit: good_value[0], level: level,
      quantity: "#{ing_vlue.round(2)} #{good_value[1]}", name: ing }
  end

  def checking_not_so_good_value(ing_vlue, ing, level)
    return unless (not_so_good_value = NOT_SO_GOOD_INGREDIENTS[:"#{ing}"]).present?

    value_percent = ((ing_vlue / not_so_good_value[0]) * 100).round
    [percent: value_percent, upper_limit: not_so_good_value[0], level: level, quantity: "#{ing_vlue.round(2)} #{not_so_good_value[1]}", name: ing]
  end

  def negative_and_positive(product)
    @product = product
    p_good = []
    neg_n_good = []
    p_good << vit_min_value(false, "vit")
    p_good << dietary_fibre if dietary_fibre.present? 
    p_good << protein_value if protein_value.present? 
    neg_n_good << calories_energy if calories_energy.present?
    saturate_fat = product_sat_fat
    neg_n_good << saturate_fat[0] if saturate_fat&.last == false || saturate_fat&.last == true
    sugar = product_sugar_level
    neg_n_good << sugar[0] if sugar&.last == false || sugar&.last == true
    sodium = product_sodium_level
    p_good << probiotic_value
    neg_n_good << sodium[0] if sodium&.last == false || sodium&.last == true
    neg_n_good << cholesterol_rda
    neg_n_good << total_fat_rda
    neg_n_good << trans_fat_rda
    @product.update(negative_not_good: (neg_n_good.flatten.compact - ['t',true, false])) if neg_n_good.present?
    @product.update(positive_good: (p_good.flatten.compact - ['t',true, false])) if p_good.present?
    @product.update(np_calculated: true)
    # @product.save!
  end

  def probiotic_value
    return unless @product.ingredient.probiotic.present?

    pro = @product.ingredient.probiotic.to_f
    level = if pro < 10**8
              'Low'
            elsif pro > 10**8
              'Medium'
            end
    value = [level: level, name: 'probiotic'] if level.present?
  end

  def cholesterol_rda
    energy = @product.ingredient.energy.to_f
    return [] if @product.ingredient.cholestrol.nil?

    cholestrol = @product.ingredient.cholestrol.to_f
    sat_fat = @product.ingredient.saturate.to_f
    case @product.product_type
    when 'solid'
      if cholestrol <= 5 && sat_fat < 1.5 && energy_from_saturated_fat
        [checking_not_so_good_value(cholestrol, 'cholesterol', 'Free'), true]
      elsif cholestrol <= 20 && sat_fat <= 1.5 && energy_from_saturated_fat
        [checking_not_so_good_value(cholestrol, 'cholesterol', 'Low'), true]
      end
    when 'beverage'
      if cholestrol <= 5 && sat_fat <= 0.75 && energy_from_saturated_fat
        [checking_not_so_good_value(cholestrol, 'cholesterol', 'Free'), true]
      elsif cholestrol <= 10 && sat_fat <= 0.75 && energy_from_saturated_fat
        [checking_not_so_good_value(cholestrol, 'cholesterol', 'Low'), true]
      end
    end
  end

  def total_fat_rda
    energy = @product.ingredient.energy.to_f
    return [] if @product.ingredient.total_fat.nil?

    total_fat = @product.ingredient.total_fat.to_f
    case @product.product_type
    when 'solid'
      if total_fat <= 0.5
        [checking_not_so_good_value(total_fat, 'total_fat', 'Free'), true]
      elsif total_fat <= 3
        [checking_not_so_good_value(total_fat, 'total_fat', 'Low'), true]
      end
    when 'beverage'
      if total_fat <= 0.5
        [checking_not_so_good_value(total_fat, 'total_fat', 'Free'), true]
      elsif total_fat <= 1.5
        [checking_not_so_good_value(total_fat, 'total_fat', 'Low'), true]
      end
    end
  end

  def trans_fat_rda
    return [] if @product.ingredient.trans_fat.nil?

    trans_fat = @product.ingredient.trans_fat.to_f
    energy = @product.ingredient.energy.to_f
    if trans_fat < 0.2
      [checking_not_so_good_value(trans_fat, 'trans_fat', 'Low'), true]
    elsif trans_fat > 0.2
      level = BxBlockCatalogue::VitaminValueService.new.trans_fat_clc(trans_fat, energy)
      [checking_not_so_good_value(trans_fat, 'trans_fat', level), true]
    end
  end

  # def vitamins_and_minrals
  #   good_ingredient = { vitamins: [percent: 0.0, upper_limit: 0.0, level: levels_for_vit_and_min(vitamin_columns), quantity: 0.0],
  #                       minerals: [percent: 0.0, upper_limit: 0.0, level: levels_for_vit_and_min(minral_columns), quantity: 0.0] }
  # end

  def calories_energy
    return unless (energy = @product.ingredient.energy).present?

    energy = energy.to_f
    energy_level = case @product.product_type
                   when 'solid'
                     'Low' if energy <= 40
                   when 'beverage'
                     if energy <= 4
                       'Free'
                     elsif energy <= 20
                       'Low'
                     end
                   end
    return [checking_not_so_good_value(energy, 'calories', energy_level)] if energy_level.present?
  end

  def product_sugar_level
    return if @product.ingredient.total_sugar.nil?

    energy = @product.ingredient.energy.to_f
    sugar = @product.ingredient.total_sugar.to_f
    pro_sugar_val = case @product.product_type
                    when 'solid'
                      if sugar <= 0.5
                        [checking_not_so_good_value(sugar, 'sugar', 'Free'), true]
                      elsif sugar >= 0.5 && sugar <= 5.0
                        [checking_not_so_good_value(sugar, 'sugar', 'Low'), true]
                      elsif sugar > 5.0
                        value = BxBlockCatalogue::VitaminValueService.new.suger_clc(@product.product_type, sugar, energy)
                        [checking_not_so_good_value(sugar, 'sugar', value), false]
                      end
                    when 'beverage'
                      if sugar < 0.5
                        [checking_not_so_good_value(sugar, 'sugar', 'Free'), true]
                      elsif sugar >= 0.5 && sugar <= 2.5
                        [checking_not_so_good_value(sugar, 'sugar', 'Low'), true]
                      elsif sugar > 2.5
                        value = BxBlockCatalogue::VitaminValueService.new.suger_clc(@product.product_type, sugar, energy)
                        [checking_not_so_good_value(sugar, 'sugar', value), false]
                      end
                    end
    pro_sugar_val || []
  end

  def nagetive_not_good_ing
    %w[saturate calories sodium sugar]
  end

  def product_sodium_level
    energy = @product.ingredient.energy.to_f
    return [] if @product.ingredient.sodium.nil?

    sodium = @product.ingredient.sodium.to_f
    case @product.product_type
    when 'solid'
      if sodium <= 0.05
        return [checking_not_so_good_value(sodium, 'sodium', 'Free'), true]
      elsif sodium <= 0.12
        return [checking_not_so_good_value(sodium, 'sodium', 'Low'), true]
      elsif sodium > 5.0
        value = BxBlockCatalogue::VitaminValueService.new.sodium_level_clc(sodium, energy)
        return [checking_not_so_good_value(sodium, 'sodium', value), false]
      end
    when 'beverage'
      if sodium <= 0.05
        return [checking_not_so_good_value(sodium, 'sodium', 'Free'), true]
      elsif sodium <= 0.12
        return [checking_not_so_good_value(sodium, 'sodium', 'Low'), true]
      elsif sodium > 5.0
        value = BxBlockCatalogue::VitaminValueService.new.sodium_level_clc(sodium, energy)
        return [checking_not_so_good_value(sodium, 'sodium', value), false]
      end
    end
    []
  end

  def check_High_sodium(energy_range, _max_)
    energy.between?(energy_range) && sodium > max_sodium
  end

  def product_sat_fat
    return if @product.ingredient.saturate.nil?

    saturate_fat = @product.ingredient.saturate.to_f
    energy = @product.ingredient.energy.to_f
    pro_sat_fat = case @product.product_type
                  when 'solid'
                    if saturate_fat <= 0.1
                      return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Free'), true]
                    elsif saturate_fat > 0.1 && saturate_fat <= 1.5 && energy_from_saturated_fat
                      return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Low'), true]
                    elsif saturate_fat >= 1.5 || energy_from_saturated_fat
                      value = BxBlockCatalogue::VitaminValueService.new.saturated_fat_clc(saturate_fat, energy)
                      rating = value != 'High'
                      return [checking_not_so_good_value(saturate_fat, 'saturated_fat', value), rating]
                    end
                  when 'beverage'
                    if saturate_fat <= 0.1
                      return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Free'), true]
                    elsif saturate_fat > 0.1 && saturate_fat <= 0.75 && energy_from_saturated_fat
                      return [checking_not_so_good_value(saturate_fat, 'saturated_fat', 'Low'), true]
                    elsif saturate_fat >= 2 || energy_from_saturated_fat
                      value = BxBlockCatalogue::VitaminValueService.new.saturated_fat_clc(saturate_fat, energy)
                      rating = value != 'High'
                      return [checking_not_so_good_value(saturate_fat, 'saturated_fat', value), rating]
                    end
                  end
  end

  def energy_from_saturated_fat
    saturate_fat = @product.ingredient.saturate.to_f
    energy_from = saturate_fat * 9
    percent = (energy_from / @product.ingredient.energy.to_f) * 100
    value = percent < 10
  end

  
end
