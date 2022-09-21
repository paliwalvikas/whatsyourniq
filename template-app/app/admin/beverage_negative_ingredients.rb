ActiveAdmin.register BxBlockBeverage::BeverageNegativeIngredient, as: "beverage_negative_ingredient" do
  menu parent: 'Master Table'
  permit_params :point, :energy, :total_sugar, :saturate, :sodium
end
