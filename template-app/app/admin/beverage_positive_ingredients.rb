ActiveAdmin.register BxBlockBeverage::BeveragePositiveIngredient, as: "beverage_positive_ingredient" do
  menu parent: 'Master Table'
  permit_params :point, :fruit_veg, :fibre, :protein
end
