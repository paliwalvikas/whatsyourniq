ActiveAdmin.register BxBlockBeverage::BeverageNegativeIngredient, as: "beverage_negative_ingredient" do
  permit_params :point, :energy, :total_sugar, :saturate, :sodium
end
