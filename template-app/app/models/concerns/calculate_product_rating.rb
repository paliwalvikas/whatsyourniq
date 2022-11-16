class CalculateProductRating 

  def calculation(product)
    np = []
    pp = []
    # unless product_point.present?
    @product = product
    ing = @product.ingredient
    neg_clumns = BxBlockCatalogue::Ingredient.column_names - (BxBlockCheeseAndOil::MicroIngredient.column_names + BxBlockCheeseAndOil::PositiveIngredient.column_names + ['product_id'])
    neg_clumns = neg_clumns.first(5)

    neg_clumns.each do |clm|
      ing_value = ing.send(clm)
      np << check_value('negative_value', clm, ing_value) if ing_value.present?
    end

    pos_clumns = BxBlockCatalogue::Ingredient.column_names - (BxBlockCheeseAndOil::MicroIngredient.column_names + BxBlockCheeseAndOil::NegativeIngredient.column_names + ['product_id'])
    if np.sum >= 11 && @product.ingredient.fruit_veg.to_i < 5
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
      @product.product_rating = nil
      @product.product_point = nil
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
      @product.product_rating = p_rating
      @product.product_point = p_point
    end
    # end

    if @product.product_rating.present?
      pr = if mp.to_f.between?(0, 4)
             @product.product_rating
           elsif mp.to_f.between?(4, 8) && @product.product_rating != 'A' && @product.product_rating != 'E'
             (@product.product_rating.ord - 1).chr
           elsif mp.to_f > (8) && @product.product_rating != 'A'
             @product.product_rating == 'D' || @product.product_rating == 'E' ? (@product.product_rating.ord - 1).chr : (@product.product_rating.ord - 2).chr
           elsif mp.to_f > (8) && @product.product_rating == 'A'
             pr = 'A'
           end
      pr = 'A' if ['@', '?'].include?(pr)
      @product.product_rating = pr
    end
    calculated = true
    @product.save!
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
    product_type = @product.product_type
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
                   monosaturated_fat polyunsaturated_fat fatty_acid mono_unsaturated_fat veg_and_nonveg gluteen_free added_sugar artificial_preservative organic vegan_product egg fish trans_fat fat].include?(ele) || ing.send(ele).nil?

    com_v = ing.send(ele)['value'].to_f
    com_lower = ing.send(ele)['lower_limit'].to_f
    com_upper = ing.send(ele)['upper_limit'].to_f
    case ing.send(ele)['sign']
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
  end

end