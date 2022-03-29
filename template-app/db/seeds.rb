# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create(email: 'ft@example.com', password: 'password', password_confirmation: 'password') 

 BxBlockCheeseAndOil::PositiveIngredient.create(point:0.0,fruit_veg:{"value"=>"40","sign"=>"less_than_equals_to"},fibre:{"value"=>"0.9","sign"=>"less_than_equals_to"},protein:{"value"=>"1.6","sign"=>"less_than_equals_to"}) 

BxBlockCheeseAndOil::PositiveIngredient.create(point:1.0,fruit_veg:{"lower_limit"=>"40","upper_limit"=>"60","sign"=>"in_between"},fibre:{"value"=>"0.9","sign"=>"greater_than"},protein:{"value"=>"1.6","sign"=>"greater_than"}) 

 BxBlockCheeseAndOil::NegativeIngredient.create(point:0.0,energy:{"value"=>"80","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"4.5","sign"=>"less_than_equals_to"},saturate:{"value"=>"1","sign"=>"less_than_equals_to"},sodium:{"value"=>"90","sign"=>"less_than_equals_to"},ratio_fatty_acid_lipids:{"value"=>"10","sign"=>"less_than"}) 

BxBlockCheeseAndOil::NegativeIngredient.create(point:1.0,energy:{"value"=>"80","sign"=>"greater_than"},total_sugar:{"value"=>"4.5","sign"=>"greater_than"},saturate:{"value"=>"1","sign"=>"greater_than"},sodium:{"value"=>"90","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"16","sign"=>"less_than"}) 

BxBlockCheeseAndOil::MicroIngredient.create(point: 0.0, vit_a: {"value"=>"50","sign"=>"less_than_equals_to"}, vit_c: {"value"=>"4","sign"=>"less_than_equals_to"}, vit_d: {"value"=>"0.75","sign"=>"less_than_equals_to"}, vit_b6: {"value"=>"0.05","sign"=>"less_than_equals_to"}, vit_b12: {"value"=>"0.125","sign"=>"less_than_equals_to"}, vit_b9: {"value"=>"15","sign"=>"less_than_equals_to"}, vit_b2: {"value"=>"0.1","sign"=>"less_than_equals_to"}, vit_b3: {"value"=>"0.75","sign"=>"less_than_equals_to"}, vit_b1: {"value"=>"0.75","sign"=>"less_than_equals_to"}, vit_b5: {"value"=>"0.25","sign"=>"less_than_equals_to"}, vit_b7: {"value"=>"2","sign"=>"less_than_equals_to"}, calcium: {"value"=>"50","sign"=>"less_than_equals_to"}, iron: {"value"=>"0.95","sign"=>"less_than_equals_to"}, magnesium: {"value"=>"19","sign"=>"less_than_equals_to"}, zinc: {"value"=>"0.85","sign"=>"less_than_equals_to"}, iodine: {"value"=>"7.5","sign"=>"less_than_equals_to"}, potassium: {"value"=>"200","sign"=>"less_than_equals_to"}, phosphorus: {"value"=>"50","sign"=>"less_than_equals_to"}, manganese: {"value"=>"0.2","sign"=>"less_than_equals_to"}, copper: {"value"=>"0.1","sign"=>"less_than_equals_to"}, selenium: {"value"=>"2","sign"=>"less_than_equals_to"}, chloride: {"value"=>"125","sign"=>"less_than_equals_to"}, chromium: {"value"=>"3","sign"=>"less_than_equals_to"}) 


BxBlockCheeseAndOil::MicroIngredient.create(point: 0.2, vit_a: {"value"=>"50","sign"=>"greater_than"}, vit_c: {"value"=>"4","sign"=>"greater_than"}, vit_d: {"value"=>"0.75","sign"=>"greater_than"}, vit_b6: {"value"=>"0.05","sign"=>"greater_than"}, vit_b12: {"value"=>"0.125","sign"=>"greater_than"}, vit_b9: {"value"=>"15","sign"=>"greater_than"}, vit_b2: {"value"=>"0.1","sign"=>"greater_than"}, vit_b3: {"value"=>"0.75","sign"=>"greater_than"}, vit_b1: {"value"=>"0.75","sign"=>"greater_than"}, vit_b5: {"value"=>"0.25","sign"=>"greater_than"}, vit_b7: {"value"=>"2","sign"=>"greater_than"}, calcium: {"value"=>"50","sign"=>"greater_than"}, iron: {"value"=>"0.95","sign"=>"greater_than"}, magnesium: {"value"=>"19","sign"=>"greater_than"}, zinc: {"value"=>"0.85","sign"=>"greater_than"}, iodine: {"value"=>"7.5","sign"=>"greater_than"}, potassium: {"value"=>"200","sign"=>"greater_than"}, phosphorus: {"value"=>"50","sign"=>"greater_than"}, manganese: {"value"=>"0.2","sign"=>"greater_than"}, copper: {"value"=>"0.1","sign"=>"greater_than"}, selenium: {"value"=>"2","sign"=>"greater_than"}, chloride: {"value"=>"125","sign"=>"greater_than"}, chromium: {"value"=>"3","sign"=>"greater_than"}) 

