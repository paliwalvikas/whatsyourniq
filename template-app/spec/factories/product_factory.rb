FactoryGirl.define do
  factory :product, class: BxBlockCatalogue::Product do
    product_type {"Beverage"}
    product_name {"THE HONEY SHOP - Honey Mango Spread - Sugar Free Mango Jam, Perfect Addition to Your Healthy Breakfast (Combination of Alphonso Mango and 100% Pure Honey), 200 gm - Pack of 1"}
    product_point {"23"}
    product_rating {"A"}
    weight {"200 Grams"}
    price_mrp {"260"}
    price_post_discount {"245"}
    brand_name {"The Honey Shop"}
    category_id {"Packaged Foods"}
    positive_good {"Good"}
    negative_not_good {"No"}
    bar_code {"B07P4286MZ"}
    data_check {"green"}
    description {"Tropical mango and 100% pure honey"}
    ingredient_list {"Tropical mango and 100% pure honey"}
    filter_category_id {1}
    filter_sub_category_id {1}
    food_drink_filter {"Drink"}
    website {"Amazon"}
    calculated {true}
    np_calculated{true}
  end
end
