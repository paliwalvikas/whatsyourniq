ActiveAdmin.register BxBlockCheeseAndOil::NegativeIngredient do
	permit_params :point, :energy, :total_sugar, :saturate, :sodium, :ratio_fatty_acid_lipids
end