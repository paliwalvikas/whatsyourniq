ActiveAdmin.register BxBlockCheeseAndOil::NegativeIngredient, as: "cheese_and_solid_negative_ingredient" do
  menu parent: 'Master Table', lable: "cheese_and_solid_negative_ingredient"
  permit_params :point, :energy, :total_sugar, :saturate, :sodium, :ratio_fatty_acid_lipids
end
