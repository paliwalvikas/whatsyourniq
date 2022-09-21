ActiveAdmin.register BxBlockCheeseAndOil::MicroIngredient, as: "cheese_and_solid_micro_ingredient" do
  menu parent: 'Master Table'
  permit_params :point, :vit_a, :vit_c, :vit_d, :vit_b6, :vit_b12, :vit_b9, :vit_b2, :vit_b3, :vit_b1, :vit_b5, :vit_b7,
                :calcium, :iron, :magnesium, :zinc, :iodine, :potassium, :phosphorus, :manganese, :copper, :selenium, :chloride, :chromium
end
