ActiveAdmin.register BxBlockBeverage::BeveragePositiveIngredient, as: "beverage_positive_ingredient" do
  permit_params :point, :fruit_veg, :fibre, :protein
end
