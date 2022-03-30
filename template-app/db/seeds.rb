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

BxBlockCheeseAndOil::PositiveIngredient.create(point:2.0,fruit_veg:{"lower_limit"=>"60","upper_limit"=>"80","sign"=>"in_between"},fibre:{"value"=>"1.9","sign"=>"greater_than"},protein:{"value"=>"3.2","sign"=>"greater_than"}) 

BxBlockCheeseAndOil::PositiveIngredient.create(point:3.0,fruit_veg:{},fibre:{"value"=>"2.8","sign"=>"greater_than"},protein:{"value"=>"4.8","sign"=>"greater_than"})

BxBlockCheeseAndOil::PositiveIngredient.create(point:4.0,fruit_veg:{},fibre:{"value"=>"3.7","sign"=>"greater_than"},protein:{"value"=>"6.4","sign"=>"greater_than"})

BxBlockCheeseAndOil::PositiveIngredient.create(point:5.0,fruit_veg:{"value"=>"80","sign"=>"greater_than"},fibre:{"value"=>"4.7","sign"=>"greater_than"},protein:{"value"=>"8","sign"=>"greater_than"})


 BxBlockCheeseAndOil::NegativeIngredient.create(point:0.0,energy:{"value"=>"80","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"4.5","sign"=>"less_than_equals_to"},saturate:{"value"=>"1","sign"=>"less_than_equals_to"},sodium:{"value"=>"90","sign"=>"less_than_equals_to"},ratio_fatty_acid_lipids:{"value"=>"10","sign"=>"less_than"}) 

BxBlockCheeseAndOil::NegativeIngredient.create(point:1.0,energy:{"value"=>"80","sign"=>"greater_than"},total_sugar:{"value"=>"4.5","sign"=>"greater_than"},saturate:{"value"=>"1","sign"=>"greater_than"},sodium:{"value"=>"90","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"16","sign"=>"less_than"}) 

BxBlockCheeseAndOil::NegativeIngredient.create(point:2.0,energy:{"value"=>"160","sign"=>"greater_than"},total_sugar:{"value"=>"9","sign"=>"greater_than"},saturate:{"value"=>"2","sign"=>"greater_than"},sodium:{"value"=>"180","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"22","sign"=>"less_than"})

BxBlockCheeseAndOil::NegativeIngredient.create(point:3.0,energy:{"value"=>"240","sign"=>"greater_than"},total_sugar:{"value"=>"13.5","sign"=>"greater_than"},saturate:{"value"=>"3","sign"=>"greater_than"},sodium:{"value"=>"270","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"28","sign"=>"less_than"})

BxBlockCheeseAndOil::NegativeIngredient.create(point:4.0,energy:{"value"=>"320","sign"=>"greater_than"},total_sugar:{"value"=>"18","sign"=>"greater_than"},saturate:{"value"=>"4","sign"=>"greater_than"},sodium:{"value"=>"360","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"34","sign"=>"less_than"})

BxBlockCheeseAndOil::NegativeIngredient.create(point:5.0,energy:{"value"=>"400","sign"=>"greater_than"},total_sugar:{"value"=>"22.5","sign"=>"greater_than"},saturate:{"value"=>"5","sign"=>"greater_than"},sodium:{"value"=>"450","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"40","sign"=>"less_than"})


BxBlockCheeseAndOil::NegativeIngredient.create(point:6.0,energy:{"value"=>"480","sign"=>"greater_than"},total_sugar:{"value"=>"27","sign"=>"greater_than"},saturate:{"value"=>"6","sign"=>"greater_than"},sodium:{"value"=>"540","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"46","sign"=>"less_than"})

BxBlockCheeseAndOil::NegativeIngredient.create(point:7.0,energy:{"value"=>"560","sign"=>"greater_than"},total_sugar:{"value"=>"31","sign"=>"greater_than"},saturate:{"value"=>"7","sign"=>"greater_than"},sodium:{"value"=>"630","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"52","sign"=>"less_than"})

BxBlockCheeseAndOil::NegativeIngredient.create(point:8.0,energy:{"value"=>"640","sign"=>"greater_than"},total_sugar:{"value"=>"36","sign"=>"greater_than"},saturate:{"value"=>"8","sign"=>"greater_than"},sodium:{"value"=>"720","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"58","sign"=>"less_than"})


BxBlockCheeseAndOil::NegativeIngredient.create(point:9.0,energy:{"value"=>"720","sign"=>"greater_than"},total_sugar:{"value"=>"40","sign"=>"greater_than"},saturate:{"value"=>"9","sign"=>"greater_than"},sodium:{"value"=>"810","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"64","sign"=>"less_than"})

BxBlockCheeseAndOil::NegativeIngredient.create(point:10.0,energy:{"value"=>"800","sign"=>"greater_than"},total_sugar:{"value"=>"45","sign"=>"greater_than"},saturate:{"value"=>"10","sign"=>"greater_than"},sodium:{"value"=>"900","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"64","sign"=>"less_than"})


# BxBlockCheeseAndOil::NegativeIngredient.create(point:4.0,energy:{"value"=>"320","sign"=>"greater_than"},total_sugar:{"value"=>"9","sign"=>"greater_than"},saturate:{"value"=>"2","sign"=>"greater_than"},sodium:{"value"=>"180","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"22","sign"=>"less_than"})



BxBlockCheeseAndOil::MicroIngredient.create(point: 0.0, vit_a: {"value"=>"50","sign"=>"less_than_equals_to"}, vit_c: {"value"=>"4","sign"=>"less_than_equals_to"}, vit_d: {"value"=>"0.75","sign"=>"less_than_equals_to"}, vit_b6: {"value"=>"0.05","sign"=>"less_than_equals_to"}, vit_b12: {"value"=>"0.125","sign"=>"less_than_equals_to"}, vit_b9: {"value"=>"15","sign"=>"less_than_equals_to"}, vit_b2: {"value"=>"0.1","sign"=>"less_than_equals_to"}, vit_b3: {"value"=>"0.75","sign"=>"less_than_equals_to"}, vit_b1: {"value"=>"0.75","sign"=>"less_than_equals_to"}, vit_b5: {"value"=>"0.25","sign"=>"less_than_equals_to"}, vit_b7: {"value"=>"2","sign"=>"less_than_equals_to"}, calcium: {"value"=>"50","sign"=>"less_than_equals_to"}, iron: {"value"=>"0.95","sign"=>"less_than_equals_to"}, magnesium: {"value"=>"19","sign"=>"less_than_equals_to"}, zinc: {"value"=>"0.85","sign"=>"less_than_equals_to"}, iodine: {"value"=>"7.5","sign"=>"less_than_equals_to"}, potassium: {"value"=>"200","sign"=>"less_than_equals_to"}, phosphorus: {"value"=>"50","sign"=>"less_than_equals_to"}, manganese: {"value"=>"0.2","sign"=>"less_than_equals_to"}, copper: {"value"=>"0.1","sign"=>"less_than_equals_to"}, selenium: {"value"=>"2","sign"=>"less_than_equals_to"}, chloride: {"value"=>"125","sign"=>"less_than_equals_to"}, chromium: {"value"=>"3","sign"=>"less_than_equals_to"}) 


BxBlockCheeseAndOil::MicroIngredient.create(point: 0.2, vit_a: {"value"=>"50","sign"=>"greater_than"}, vit_c: {"value"=>"4","sign"=>"greater_than"}, vit_d: {"value"=>"0.75","sign"=>"greater_than"}, vit_b6: {"value"=>"0.05","sign"=>"greater_than"}, vit_b12: {"value"=>"0.125","sign"=>"greater_than"}, vit_b9: {"value"=>"15","sign"=>"greater_than"}, vit_b2: {"value"=>"0.1","sign"=>"greater_than"}, vit_b3: {"value"=>"0.75","sign"=>"greater_than"}, vit_b1: {"value"=>"0.75","sign"=>"greater_than"}, vit_b5: {"value"=>"0.25","sign"=>"greater_than"}, vit_b7: {"value"=>"2","sign"=>"greater_than"}, calcium: {"value"=>"50","sign"=>"greater_than"}, iron: {"value"=>"0.95","sign"=>"greater_than"}, magnesium: {"value"=>"19","sign"=>"greater_than"}, zinc: {"value"=>"0.85","sign"=>"greater_than"}, iodine: {"value"=>"7.5","sign"=>"greater_than"}, potassium: {"value"=>"200","sign"=>"greater_than"}, phosphorus: {"value"=>"50","sign"=>"greater_than"}, manganese: {"value"=>"0.2","sign"=>"greater_than"}, copper: {"value"=>"0.1","sign"=>"greater_than"}, selenium: {"value"=>"2","sign"=>"greater_than"}, chloride: {"value"=>"125","sign"=>"greater_than"}, chromium: {"value"=>"3","sign"=>"greater_than"}) 

BxBlockCheeseAndOil::MicroIngredient.create(point: 0.4, vit_a: {"value"=>"100","sign"=>"greater_than"}, vit_c: {"value"=>"8","sign"=>"greater_than"}, vit_d: {"value"=>"1.5","sign"=>"greater_than"}, vit_b6: {"value"=>"0.1","sign"=>"greater_than"}, vit_b12: {"value"=>"0.25","sign"=>"greater_than"}, vit_b9: {"value"=>"30","sign"=>"greater_than"}, vit_b2: {"value"=>"0.2","sign"=>"greater_than"}, vit_b3: {"value"=>"1.5","sign"=>"greater_than"}, vit_b1: {"value"=>"1.5","sign"=>"greater_than"}, vit_b5: {"value"=>"0.5","sign"=>"greater_than"}, vit_b7: {"value"=>"4","sign"=>"greater_than"}, calcium: {"value"=>"100","sign"=>"greater_than"}, iron: {"value"=>"1.9","sign"=>"greater_than"}, magnesium: {"value"=>"38","sign"=>"greater_than"}, zinc: {"value"=>"1.7","sign"=>"greater_than"}, iodine: {"value"=>"15","sign"=>"greater_than"}, potassium: {"value"=>"400","sign"=>"greater_than"}, phosphorus: {"value"=>"100","sign"=>"greater_than"}, manganese: {"value"=>"0.4","sign"=>"greater_than"}, copper: {"value"=>"0.2","sign"=>"greater_than"}, selenium: {"value"=>"4","sign"=>"greater_than"}, chloride: {"value"=>"250","sign"=>"greater_than"}, chromium: {"value"=>"6","sign"=>"greater_than"}) 

BxBlockCheeseAndOil::MicroIngredient.create(point: 0.6, vit_a: {"value"=>"150","sign"=>"greater_than"}, vit_c: {"value"=>"12","sign"=>"greater_than"}, vit_d: {"value"=>"2.25","sign"=>"greater_than"}, vit_b6: {"value"=>"0.285","sign"=>"greater_than"}, vit_b12: {"value"=>"0.375","sign"=>"greater_than"}, vit_b9: {"value"=>"45","sign"=>"greater_than"}, vit_b2: {"value"=>"0.3","sign"=>"greater_than"}, vit_b3: {"value"=>"2.1","sign"=>"greater_than"}, vit_b1: {"value"=>"2.163","sign"=>"greater_than"}, vit_b5: {"value"=>"0.75","sign"=>"greater_than"}, vit_b7: {"value"=>"6","sign"=>"greater_than"}, calcium: {"value"=>"150","sign"=>"greater_than"}, iron: {"value"=>"2.85","sign"=>"greater_than"}, magnesium: {"value"=>"58","sign"=>"greater_than"}, zinc: {"value"=>"2.52","sign"=>"greater_than"}, iodine: {"value"=>"22.5","sign"=>"greater_than"}, potassium: {"value"=>"525","sign"=>"greater_than"}, phosphorus: {"value"=>"150","sign"=>"greater_than"}, manganese: {"value"=>"0.6","sign"=>"greater_than"}, copper: {"value"=>"0.3","sign"=>"greater_than"}, selenium: {"value"=>"6","sign"=>"greater_than"}, chloride: {"value"=>"345","sign"=>"greater_than"}, chromium: {"value"=>"7.5","sign"=>"greater_than"}) 

BxBlockBeverage::BeverageNegativeIngredient.create(point:0.0,energy:{"value"=>"0","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"0","sign"=>"less_than_equals_to"},saturate:{"value"=>"1","sign"=>"less_than_equals_to"},sodium:{"value"=>"90","sign"=>"less_than_equals_to"})

BxBlockBeverage::BeverageNegativeIngredient.create(point:1.0,energy:{"value"=>"7","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"1.5","sign"=>"less_than_equals_to"},saturate:{"value"=>"1","sign"=>"greater_than"},sodium:{"value"=>"90","sign"=>"greater_than"})


BxBlockBeverage::BeverageNegativeIngredient.create(point:2.0,energy:{"value"=>"14","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"3","sign"=>"less_than_equals_to"},saturate:{"value"=>"2","sign"=>"greater_than"},sodium:{"value"=>"180","sign"=>"greater_than"})

BxBlockBeverage::BeverageNegativeIngredient.create(point:3.0,energy:{"value"=>"22","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"4.5","sign"=>"less_than_equals_to"},saturate:{"value"=>"3","sign"=>"greater_than"},sodium:{"value"=>"270","sign"=>"greater_than"})

BxBlockBeverage::BeverageNegativeIngredient.create(point:4.0,energy:{"value"=>"29","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"6","sign"=>"less_than_equals_to"},saturate:{"value"=>"4","sign"=>"greater_than"},sodium:{"value"=>"360","sign"=>"greater_than"})

BxBlockBeverage::BeverageNegativeIngredient.create(point:5.0,energy:{"value"=>"36","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"7.5","sign"=>"less_than_equals_to"},saturate:{"value"=>"5","sign"=>"greater_than"},sodium:{"value"=>"450","sign"=>"greater_than"})

BxBlockBeverage::BeverageNegativeIngredient.create(point:6.0,energy:{"value"=>"43","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"9","sign"=>"less_than_equals_to"},saturate:{"value"=>"6","sign"=>"greater_than"},sodium:{"value"=>"540","sign"=>"greater_than"})

BxBlockBeverage::BeverageNegativeIngredient.create(point:7.0,energy:{"value"=>"50","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"10.5","sign"=>"less_than_equals_to"},saturate:{"value"=>"7","sign"=>"greater_than"},sodium:{"value"=>"630","sign"=>"greater_than"})

BxBlockBeverage::BeverageNegativeIngredient.create(point:8.0,energy:{"value"=>"57","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"12","sign"=>"less_than_equals_to"},saturate:{"value"=>"8","sign"=>"greater_than"},sodium:{"value"=>"720","sign"=>"greater_than"})

BxBlockBeverage::BeverageNegativeIngredient.create(point:9.0,energy:{"value"=>"64","sign"=>"greater_than"},total_sugar:{"value"=>"13.5","sign"=>"greater_than"},saturate:{"value"=>"10","sign"=>"greater_than"},sodium:{"value"=>"900","sign"=>"greater_than"})


BxBlockBeverage::BeverageNegativeIngredient.create(point:10.0,energy:{"value"=>"64","sign"=>"less_than_equals_to"},total_sugar:{"value"=>"13.5","sign"=>"less_than_equals_to"},saturate:{"value"=>"9","sign"=>"greater_than"},sodium:{"value"=>"810","sign"=>"greater_than"})


BxBlockBeverage::BeveragePositiveIngredient.create(point:0.0,fruit_veg:{"value"=>"40","sign"=>"less_than_equals_to"},fibre:{"value"=>"0.9","sign"=>"less_than_equals_to"},protein:{"value"=>"1.6","sign"=>"less_than_equals_to"})


BxBlockBeverage::BeveragePositiveIngredient.create(point:1.0,fruit_veg:{},fibre:{"value"=>"0.9","sign"=>"greater_than"},protein:{"value"=>"1.6","sign"=>"greater_than"})


BxBlockBeverage::BeveragePositiveIngredient.create(point:2.0,fruit_veg:{"lower_limit"=>"40","upper_limit"=>"60","sign"=>"in_between"},fibre:{"value"=>"1.9","sign"=>"greater_than"},protein:{"value"=>"3.2","sign"=>"greater_than"})

BxBlockBeverage::BeveragePositiveIngredient.create(point:3.0,fruit_veg:{},fibre:{"value"=>"2.8","sign"=>"greater_than"},protein:{"value"=>"4.8","sign"=>"greater_than"})

BxBlockBeverage::BeveragePositiveIngredient.create(point:4.0,fruit_veg:{"lower_limit"=>"60","upper_limit"=>"80","sign"=>"in_between"},fibre:{"value"=>"3.7","sign"=>"greater_than"},protein:{"value"=>"6.4","sign"=>"greater_than"})

BxBlockBeverage::BeveragePositiveIngredient.create(point:5.0,fruit_veg:{},fibre:{"value"=>"4.7","sign"=>"greater_than"},protein:{"value"=>"8","sign"=>"greater_than"})

BxBlockBeverage::BeveragePositiveIngredient.create(point:10.0,fruit_veg:{"value"=>"80","sign"=>"greater_than"},fibre:{},protein:{})

BxBlockBeverage::BeverageMicroIngredient.create(point: 0.0, vit_a: {"value"=>"25","sign"=>"less_than_equals_to"}, vit_c: {"value"=>"2","sign"=>"less_than_equals_to"}, vit_d: {"value"=>"0.375","sign"=>"less_than_equals_to"}, vit_b6: {"value"=>"0.025","sign"=>"less_than_equals_to"}, vit_b12: {"value"=>"0.062","sign"=>"less_than_equals_to"}, vit_b9: {"value"=>"8","sign"=>"less_than_equals_to"}, vit_b2: {"value"=>"0.05","sign"=>"less_than_equals_to"}, vit_b3: {"value"=>"0.375","sign"=>"less_than_equals_to"}, vit_b1: {"value"=>"0.375","sign"=>"less_than_equals_to"}, vit_b5: {"value"=>"0.125","sign"=>"less_than_equals_to"}, vit_b7: {"value"=>"1","sign"=>"less_than_equals_to"}, calcium: {"value"=>"25","sign"=>"less_than_equals_to"}, iron: {"value"=>"0.5","sign"=>"less_than_equals_to"}, magnesium: {"value"=>"10","sign"=>"less_than_equals_to"}, zinc: {"value"=>"0.425","sign"=>"less_than_equals_to"}, iodine: {"value"=>"3.75","sign"=>"less_than_equals_to"}, potassium: {"value"=>"100","sign"=>"less_than_equals_to"}, phosphorus: {"value"=>"25","sign"=>"less_than_equals_to"}, manganese: {"value"=>"0.1","sign"=>"less_than_equals_to"}, copper: {"value"=>"0.05","sign"=>"less_than_equals_to"}, selenium: {"value"=>"1","sign"=>"less_than_equals_to"}, chloride: {"value"=>"62.5","sign"=>"less_than_equals_to"}, chromium: {"value"=>"1.5","sign"=>"less_than_equals_to"})

BxBlockBeverage::BeverageMicroIngredient.create(point: 0.2, vit_a: {"value"=>"25","sign"=>"greater_than"}, vit_c: {"value"=>"2","sign"=>"greater_than"}, vit_d: {"value"=>"0.375","sign"=>"greater_than"}, vit_b6: {"value"=>"0.025","sign"=>"greater_than"}, vit_b12: {"value"=>"0.062","sign"=>"greater_than"}, vit_b9: {"value"=>"8","sign"=>"greater_than"}, vit_b2: {"value"=>"0.05","sign"=>"greater_than"}, vit_b3: {"value"=>"0.375","sign"=>"greater_than"}, vit_b1: {"value"=>"0.375","sign"=>"greater_than"}, vit_b5: {"value"=>"0.125","sign"=>"greater_than"}, vit_b7: {"value"=>"1","sign"=>"greater_than"}, calcium: {"value"=>"25","sign"=>"greater_than"}, iron: {"value"=>"0.5","sign"=>"greater_than"}, magnesium: {"value"=>"10","sign"=>"greater_than"}, zinc: {"value"=>"0.425","sign"=>"greater_than"}, iodine: {"value"=>"3.75","sign"=>"greater_than"}, potassium: {"value"=>"100","sign"=>"greater_than"}, phosphorus: {"value"=>"25","sign"=>"greater_than"}, manganese: {"value"=>"0.1","sign"=>"greater_than"}, copper: {"value"=>"0.05","sign"=>"greater_than"}, selenium: {"value"=>"1","sign"=>"greater_than"}, chloride: {"value"=>"62.5","sign"=>"greater_than"}, chromium: {"value"=>"1.5","sign"=>"greater_than"})


BxBlockBeverage::BeverageMicroIngredient.create(point: 0.4, vit_a: {"value"=>"50","sign"=>"greater_than"}, vit_c: {"value"=>"4","sign"=>"greater_than"}, vit_d: {"value"=>"0.75","sign"=>"greater_than"}, vit_b6: {"value"=>"0.5","sign"=>"greater_than"}, vit_b12: {"value"=>"0.125","sign"=>"greater_than"}, vit_b9: {"value"=>"15","sign"=>"greater_than"}, vit_b2: {"value"=>"0.1","sign"=>"greater_than"}, vit_b3: {"value"=>"0.75","sign"=>"greater_than"}, vit_b1: {"value"=>"0.75","sign"=>"greater_than"}, vit_b5: {"value"=>"0.25","sign"=>"greater_than"}, vit_b7: {"value"=>"2","sign"=>"greater_than"}, calcium: {"value"=>"50","sign"=>"greater_than"}, iron: {"value"=>"1.0","sign"=>"greater_than"}, magnesium: {"value"=>"19","sign"=>"greater_than"}, zinc: {"value"=>"0.85","sign"=>"greater_than"}, iodine: {"value"=>"7.5","sign"=>"greater_than"}, potassium: {"value"=>"200","sign"=>"greater_than"}, phosphorus: {"value"=>"50","sign"=>"greater_than"}, manganese: {"value"=>"0.2","sign"=>"greater_than"}, copper: {"value"=>"0.1","sign"=>"greater_than"}, selenium: {"value"=>"2","sign"=>"greater_than"}, chloride: {"value"=>"125","sign"=>"greater_than"}, chromium: {"value"=>"3","sign"=>"greater_than"})

BxBlockBeverage::BeverageMicroIngredient.create(point: 0.6, vit_a: {"value"=>"75","sign"=>"greater_than"}, vit_c: {"value"=>"6","sign"=>"greater_than"}, vit_d: {"value"=>"1.12","sign"=>"greater_than"}, vit_b6: {"value"=>"0.14","sign"=>"greater_than"}, vit_b12: {"value"=>"0.19","sign"=>"greater_than"}, vit_b9: {"value"=>"22.5","sign"=>"greater_than"}, vit_b2: {"value"=>"0.19","sign"=>"greater_than"}, vit_b3: {"value"=>"1.05","sign"=>"greater_than"}, vit_b1: {"value"=>"1.08","sign"=>"greater_than"}, vit_b5: {"value"=>"0.375","sign"=>"greater_than"}, vit_b7: {"value"=>"3","sign"=>"greater_than"}, calcium: {"value"=>"75","sign"=>"greater_than"}, iron: {"value"=>"1.425","sign"=>"greater_than"}, magnesium: {"value"=>"29","sign"=>"greater_than"}, zinc: {"value"=>"1.275","sign"=>"greater_than"}, iodine: {"value"=>"11.25","sign"=>"greater_than"}, potassium: {"value"=>"262.5","sign"=>"greater_than"}, phosphorus: {"value"=>"75","sign"=>"greater_than"}, manganese: {"value"=>"0.3","sign"=>"greater_than"}, copper: {"value"=>"0.125","sign"=>"greater_than"}, selenium: {"value"=>"3","sign"=>"greater_than"}, chloride: {"value"=>"221","sign"=>"greater_than"}, chromium: {"value"=>"3.75","sign"=>"greater_than"})


BxBlockBeverage::BeverageMicroIngredient.create(point: 0.8, vit_a: {"value"=>"112","sign"=>"greater_than"}, vit_c: {"value"=>"9","sign"=>"greater_than"}, vit_d: {"value"=>"1.69","sign"=>"greater_than"}, vit_b6: {"value"=>"0.21","sign"=>"greater_than"}, vit_b12: {"value"=>"0.28","sign"=>"greater_than"}, vit_b9: {"value"=>"33.75","sign"=>"greater_than"}, vit_b2: {"value"=>"0.2","sign"=>"greater_than"}, vit_b3: {"value"=>"1.5","sign"=>"greater_than"}, vit_b1: {"value"=>"1.5","sign"=>"greater_than"}, vit_b5: {"value"=>"0.5","sign"=>"greater_than"}, vit_b7: {"value"=>"4.5","sign"=>"greater_than"}, calcium: {"value"=>"112","sign"=>"greater_than"}, iron: {"value"=>"2.13","sign"=>"greater_than"}, magnesium: {"value"=>"43","sign"=>"greater_than"}, zinc: {"value"=>"1.91","sign"=>"greater_than"}, iodine: {"value"=>"16.25","sign"=>"greater_than"}, potassium: {"value"=>"393.75","sign"=>"greater_than"}, phosphorus: {"value"=>"97.5","sign"=>"greater_than"}, manganese: {"value"=>"0.45","sign"=>"greater_than"}, copper: {"value"=>"0.1875","sign"=>"greater_than"}, selenium: {"value"=>"4.5","sign"=>"greater_than"}, chloride: {"value"=>"335","sign"=>"greater_than"}, chromium: {"value"=>"5.5","sign"=>"greater_than"})
