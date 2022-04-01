ActiveAdmin.register BxBlockCheeseAndOil::PositiveIngredient, as: "cheese_and_solid_positive_ingredient" do
  permit_params :point, :fruit_veg, :fibre, :protein
end
