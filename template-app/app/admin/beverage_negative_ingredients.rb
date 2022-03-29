ActiveAdmin.register BxBlockBeverage::BeverageNegativeIngredient do
	permit_params :point, :energy, :total_sugar, :saturate, :sodium
end