ActiveAdmin.register BxBlockBeverage::BeveragePositiveIngredient do
	permit_params :point, :fruit_veg, :fibre ,:protein
end