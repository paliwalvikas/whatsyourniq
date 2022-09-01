# frozen_string_literal: true

# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create(email: 'ft@example.com', password: 'password', password_confirmation: 'password') unless AdminUser.find_by(email: 'ft@example.com')

# BxBlockCheeseAndOil::PositiveIngredient.create(point: 0.0, fruit_veg: { 'value' => '40.0', 'sign' => 'less_than_equals_to' },fibre: { 'value' => '0.9', 'sign' => 'less_than_equals_to' }, protein: { 'value' => '1.6', 'sign' => 'less_than_equals_to' })

# BxBlockCheeseAndOil::PositiveIngredient.create(point: 1.0,fruit_veg: { 'lower_limit' => '40.1', 'upper_limit' => '60.0', 'sign' => 'in_between' }, fibre: { 'lower_limit' => '0.9','upper_limit'=>'1.9', 'sign' => 'in_between' }, protein: { 'lower_limit' => '1.6','upper_limit'=>'3.2', 'sign' => 'in_between' })

# BxBlockCheeseAndOil::PositiveIngredient.create(point: 2.0,fruit_veg: { 'lower_limit' => '60.1', 'upper_limit' => '80.0', 'sign' => 'in_between' }, fibre: { 'lower_limit' => '2.0','upper_limit'=>'2.8', 'sign' => 'in_between' }, protein: { 'lower_limit' => '3.3','upper_limit'=>'4.8', 'sign' => 'in_between' })


# BxBlockCheeseAndOil::PositiveIngredient.create(point: 3.0, fruit_veg: {}, fibre: { 'lower_limit' => '2.9','upper_limit'=>'3.7', 'sign' => 'in_between' }, protein: { 'lower_limit' => '4.9','upper_limit'=>'6.4', 'sign' => 'in_between' })


# BxBlockCheeseAndOil::PositiveIngredient.create(point: 4.0, fruit_veg: {}, fibre: { 'lower_limit' => '3.8','upper_limit'=>'4.7', 'sign' => 'in_between' }, protein: { 'lower_limit' => '6.5','upper_limit'=>'8.0', 'sign' => 'in_between' })

# BxBlockCheeseAndOil::PositiveIngredient.create(point: 5.0, fruit_veg: { 'value' => '80', 'sign' => 'greater_than' },fibre: { 'value' => '4.8', 'sign' => 'greater_than' }, protein: { 'value' => '8.1', 'sign' => 'greater_than' })

# BxBlockCheeseAndOil::NegativeIngredient.create(point: 0.0, energy: { 'value' => '80', 'sign' => 'less_than_equals_to' },total_sugar: { 'value' => '4.5', 'sign' => 'less_than_equals_to' }, saturate: { 'value' => '1', 'sign' => 'less_than_equals_to' }, sodium: { 'value' => '90', 'sign' => 'less_than_equals_to' }, ratio_fatty_acid_lipids: { 'value' => '10', 'sign' => 'less_than' })

# BxBlockCheeseAndOil::NegativeIngredient.create(point: 1.0, energy: { 'lower_limit' =>'80.1','upper_limit'=>'160.0', 'sign' => 'in_between' },total_sugar: {  'lower_limit' =>'4.5','upper_limit'=>'9.0', 'sign' => 'in_between'}, saturate: {  'lower_limit' =>'1.1','upper_limit'=>'2.0', 'sign' => 'in_between' }, sodium: {  'lower_limit' =>'90.1','upper_limit'=>'180.0', 'sign' => 'in_between'}, ratio_fatty_acid_lipids: { 'value' => '16', 'sign' => 'less_than' })

# BxBlockCheeseAndOil::NegativeIngredient.create(point: 2.0,energy: { 'lower_limit' =>'160.1','upper_limit'=>'240.0', 'sign' => 'in_between' },total_sugar: {  'lower_limit' =>'9.1','upper_limit'=>'13.5', 'sign' => 'in_between'}, saturate: {  'lower_limit' =>'2.1','upper_limit'=>'3.0', 'sign' => 'in_between' }, sodium: {  'lower_limit' =>'180.1','upper_limit'=>'270.0', 'sign' => 'in_between'}, ratio_fatty_acid_lipids: { 'value' => '22', 'sign' => 'less_than' })

# BxBlockCheeseAndOil::NegativeIngredient.create(point: 3.0, energy: { 'lower_limit' =>'240.1','upper_limit'=>'320.0', 'sign' => 'in_between' },total_sugar: {  'lower_limit' =>'13.6','upper_limit'=>'18.0', 'sign' => 'in_between'}, saturate: {  'lower_limit' =>'3.1','upper_limit'=>'4.0', 'sign' => 'in_between' }, sodium: {  'lower_limit' =>'270.1','upper_limit'=>'360.0', 'sign' => 'in_between'}, ratio_fatty_acid_lipids: { 'value' => '28', 'sign' => 'less_than' })

# BxBlockCheeseAndOil::NegativeIngredient.create(point: 4.0,energy: { 'lower_limit' =>'320.1','upper_limit'=>'400.0', 'sign' => 'in_between' },total_sugar: {  'lower_limit' =>'18.1','upper_limit'=>'22.5', 'sign' => 'in_between'}, saturate: {  'lower_limit' =>'4.1','upper_limit'=>'5.0', 'sign' => 'in_between' }, sodium: {  'lower_limit' =>'360.1','upper_limit'=>'450.0', 'sign' => 'in_between'}, ratio_fatty_acid_lipids: { 'value' => '34', 'sign' => 'less_than' })

# BxBlockCheeseAndOil::NegativeIngredient.create(point: 5.0,energy: { 'lower_limit' =>'400.1','upper_limit'=>'480.0', 'sign' => 'in_between' },total_sugar: {  'lower_limit' =>'22.6','upper_limit'=>'27.0', 'sign' => 'in_between'}, saturate: {  'lower_limit' =>'5.1','upper_limit'=>'6.0', 'sign' => 'in_between' }, sodium: {  'lower_limit' =>'450.1','upper_limit'=>'540.0', 'sign' => 'in_between'}, ratio_fatty_acid_lipids: { 'value' => '40', 'sign' => 'less_than' })

# BxBlockCheeseAndOil::NegativeIngredient.create(point: 6.0,energy: { 'lower_limit' =>'480.1','upper_limit'=>'560.0', 'sign' => 'in_between' },total_sugar: {  'lower_limit' =>'27.1','upper_limit'=>'31.0', 'sign' => 'in_between'}, saturate: {  'lower_limit' =>'6.1','upper_limit'=>'7.0', 'sign' => 'in_between' }, sodium: {  'lower_limit' =>'540.1','upper_limit'=>'630.0', 'sign' => 'in_between'}, ratio_fatty_acid_lipids: { 'value' => '46', 'sign' => 'less_than' })

# BxBlockCheeseAndOil::NegativeIngredient.create(point: 7.0,energy: { 'lower_limit' =>'560.1','upper_limit'=>'640.0', 'sign' => 'in_between' },total_sugar: {  'lower_limit' =>'31.1','upper_limit'=>'36.0', 'sign' => 'in_between'}, saturate: {  'lower_limit' =>'7.1','upper_limit'=>'8.0', 'sign' => 'in_between' }, sodium: {  'lower_limit' =>'630.1','upper_limit'=>'720.0', 'sign' => 'in_between'}, ratio_fatty_acid_lipids: { 'value' => '52', 'sign' => 'less_than' })

# BxBlockCheeseAndOil::NegativeIngredient.create(point: 8.0, energy: { 'lower_limit' =>'640.1','upper_limit'=>'720.0', 'sign' => 'in_between' },total_sugar: {  'lower_limit' =>'36.1','upper_limit'=>'40.0', 'sign' => 'in_between'}, saturate: {  'lower_limit' =>'8.1','upper_limit'=>'9.0', 'sign' => 'in_between' }, sodium: {  'lower_limit' =>'720.1','upper_limit'=>'810.0', 'sign' => 'in_between'}, ratio_fatty_acid_lipids: { 'value' => '58', 'sign' => 'less_than' })

# BxBlockCheeseAndOil::NegativeIngredient.create(point: 9.0,energy: { 'lower_limit' =>'720.1','upper_limit'=>'800.0', 'sign' => 'in_between' },total_sugar: {  'lower_limit' =>'40.1','upper_limit'=>'45.0', 'sign' => 'in_between'}, saturate: {  'lower_limit' =>'9.1','upper_limit'=>'10.0', 'sign' => 'in_between' }, sodium: {  'lower_limit' =>'810.1','upper_limit'=>'900.0', 'sign' => 'in_between'}, ratio_fatty_acid_lipids: { 'value' => '64', 'sign' => 'less_than' })

# BxBlockCheeseAndOil::NegativeIngredient.create(point: 10.0, energy: { 'value' => '800.1', 'sign' => 'greater_than' },total_sugar: { 'value' => '45.1', 'sign' => 'greater_than' }, saturate: { 'value' => '10.1', 'sign' => 'greater_than' }, sodium: { 'value' => '900.1', 'sign' => 'greater_than' }, ratio_fatty_acid_lipids: { 'value' => '64', 'sign' => 'less_than' })

# # BxBlockCheeseAndOil::NegativeIngredient.create(point:4.0,energy:{"value"=>"320","sign"=>"greater_than"},total_sugar:{"value"=>"9","sign"=>"greater_than"},saturate:{"value"=>"2","sign"=>"greater_than"},sodium:{"value"=>"180","sign"=>"greater_than"},ratio_fatty_acid_lipids:{"value"=>"22","sign"=>"less_than"})

# BxBlockCheeseAndOil::MicroIngredient.create(point: 0.0, vit_a: { 'value' => '50','sign' => 'less_than_equals_to' },vit_c: { 'value' => '4', 'sign' => 'less_than_equals_to' }, vit_d: { 'value' => '0.75', 'sign' => 'less_than_equals_to' }, vit_b6: { 'value' => '0.05', 'sign' => 'less_than_equals_to' }, vit_b12: { 'value' => '0.125', 'sign' => 'less_than_equals_to' }, vit_b9: { 'value' => '15', 'sign' => 'less_than_equals_to' }, vit_b2: { 'value' => '0.1', 'sign' => 'less_than_equals_to' }, vit_b3: { 'value' => '0.75', 'sign' => 'less_than_equals_to' }, vit_b1: { 'value' => '0.75', 'sign' => 'less_than_equals_to' }, vit_b5: { 'value' => '0.25', 'sign' => 'less_than_equals_to' }, vit_b7: { 'value' => '2', 'sign' => 'less_than_equals_to' }, calcium: { 'value' => '50', 'sign' => 'less_than_equals_to' }, iron: { 'value' => '0.95', 'sign' => 'less_than_equals_to' }, magnesium: { 'value' => '19', 'sign' => 'less_than_equals_to' }, zinc: { 'value' => '0.85', 'sign' => 'less_than_equals_to' }, iodine: { 'value' => '7.5', 'sign' => 'less_than_equals_to' }, potassium: { 'value' => '200', 'sign' => 'less_than_equals_to' }, phosphorus: { 'value' => '50', 'sign' => 'less_than_equals_to' }, manganese: { 'value' => '0.2', 'sign' => 'less_than_equals_to' }, copper: { 'value' => '0.1', 'sign' => 'less_than_equals_to' }, selenium: { 'value' => '2', 'sign' => 'less_than_equals_to' }, chloride: { 'value' => '125', 'sign' => 'less_than_equals_to' }, chromium: { 'value' => '3', 'sign' => 'less_than_equals_to' })

# BxBlockCheeseAndOil::MicroIngredient.create(point: 0.2, vit_a: { 'lower_limit' => '50.1','upper_limit'=>'100.0', 'sign' => 'in_between' },vit_c: { 'lower_limit' => '4.1','upper_limit'=>'8.0', 'sign' => 'in_between' }, vit_d: { 'lower_limit' => '0.76','upper_limit'=>'1.5' ,'sign' => 'in_between' },vit_b6:{'lower_limit'=>'0.06','upper_limit'=>'0.1','sign'=>'in_between'},vit_b12:{'lower_limit'=>'0.126','upper_limit'=>'0.25','sign'=>'in_between'},vit_b9:{'lower_limit'=>'15.1','upper_limit'=>'30.0','sign'=>'in_between'},vit_b2:{'lower_limit'=>'0.1','upper_limit'=>'0.2','sign'=>'in_between'},vit_b3:{'lower_limit'=>'0.76','upper_limit'=>'1.5','sign'=>'in_between'},vit_b1:{'lower_limit'=>'0.76','upper_limit'=>'1.5','sign'=>'in_between'},vit_b5:{'lower_limit'=>'0.26','upper_limit'=>'0.5','sign'=>'in_between'},vit_b7:{'lower_limit'=>'2.1','upper_limit'=>'4.0','sign'=>'in_between'},calcium:{'lower_limit'=>'50.1','upper_limit'=>'100.0','sign'=>'in_between'},iron:{'lower_limit'=>'0.96','upper_limit'=>'1.9','sign'=>'in_between'},magnesium:{'lower_limit'=>'19.0','upper_limit'=>'38.0','sign'=>'in_between'},zinc:{'lower_limit'=>'0.85','upper_limit'=>'1.7','sign'=>'in_between'},iodine:{'lower_limit'=>'7.5','upper_limit'=>'15.0','sign'=>'in_between'},potassium:{'lower_limit'=>'200.1','upper_limit'=>'400.0','sign'=>'in_between'},phosphorus:{'lower_limit'=>'50.1','upper_limit'=>'100.0','sign'=>'in_between'},manganese:{'lower_limit'=>'0.2','upper_limit'=>'0.4','sign'=>'in_between'},copper:{'lower_limit'=>'0.1','upper_limit'=>'0.2','sign'=>'in_between'},selenium:{'lower_limit'=>'2.0','upper_limit'=>'4.0','sign'=>'in_between'},chloride:{'lower_limit'=>'125.0','upper_limit'=>'250.0','sign'=>'in_between'},chromium:{'lower_limit'=>'3.0','upper_limit'=>'6.0','sign'=>'in_between'})

# BxBlockCheeseAndOil::MicroIngredient.create(point: 0.4, vit_a: { 'lower_limit' => '100.0','upper_limit'=>'150.0', 'sign' => 'in_between' },vit_c: { 'lower_limit' => '8.1','upper_limit'=>'12.0', 'sign' => 'in_between' }, vit_d: { 'lower_limit' => '1.6','upper_limit'=>'2.25' ,'sign' => 'in_between' },vit_b6:{'lower_limit'=>'0.1','upper_limit'=>'0.285','sign'=>'in_between'},vit_b12:{'lower_limit'=>'0.25','upper_limit'=>'0.375','sign'=>'in_between'},vit_b9:{'lower_limit'=>'30.0','upper_limit'=>'45.0','sign'=>'in_between'},vit_b2:{'lower_limit'=>'0.2','upper_limit'=>'0.3','sign'=>'in_between'},vit_b3:{'lower_limit'=>'1.5','upper_limit'=>'2.1','sign'=>'in_between'},vit_b1:{'lower_limit'=>'1.5','upper_limit'=>'2.163','sign'=>'in_between'},vit_b5:{'lower_limit'=>'0.5','upper_limit'=>'0.75','sign'=>'in_between'},vit_b7:{'lower_limit'=>'4.0','upper_limit'=>'6.0','sign'=>'in_between'},calcium:{'lower_limit'=>'100.0','upper_limit'=>'150.0','sign'=>'in_between'},iron:{'lower_limit'=>'1.96','upper_limit'=>'2.85','sign'=>'in_between'},magnesium:{'lower_limit'=>'38.0','upper_limit'=>'58.0','sign'=>'in_between'},zinc:{'lower_limit'=>'1.7','upper_limit'=>'2.55','sign'=>'in_between'},iodine:{'lower_limit'=>'15.0','upper_limit'=>'22.5','sign'=>'in_between'},potassium:{'lower_limit'=>'400.0','upper_limit'=>'525.0','sign'=>'in_between'},phosphorus:{'lower_limit'=>'100.0','upper_limit'=>'150.0','sign'=>'in_between'},manganese:{'lower_limit'=>'0.4','upper_limit'=>'0.6','sign'=>'in_between'},copper:{'lower_limit'=>'0.2','upper_limit'=>'0.3','sign'=>'in_between'},selenium:{'lower_limit'=>'4.0','upper_limit'=>'6.0','sign'=>'in_between'},chloride:{'lower_limit'=>'250.0','upper_limit'=>'345.0','sign'=>'in_between'},chromium:{'lower_limit'=>'6.0','upper_limit'=>'7.5','sign'=>'in_between'})

# BxBlockCheeseAndOil::MicroIngredient.create(point: 0.6, vit_a: { 'lower_limit' => '150.0','upper_limit'=>'225.0', 'sign' => 'in_between' },vit_c: { 'lower_limit' => '12.0','upper_limit'=>'18.0', 'sign' => 'in_between' }, vit_d: { 'lower_limit' => '2.25','upper_limit'=>'3.375' ,'sign' => 'in_between' },vit_b6:{'lower_limit'=>'0.285','upper_limit'=>'0.428','sign'=>'in_between'},vit_b12:{'lower_limit'=>'0.375','upper_limit'=>'0.563','sign'=>'in_between'},vit_b9:{'lower_limit'=>'45.0','upper_limit'=>'67.5','sign'=>'in_between'},vit_b2:{'lower_limit'=>'0.3','upper_limit'=>'0.45','sign'=>'in_between'},vit_b3:{'lower_limit'=>'2.1','upper_limit'=>'3.1','sign'=>'in_between'},vit_b1:{'lower_limit'=>'2.163','upper_limit'=>'3.1','sign'=>'in_between'},vit_b5:{'lower_limit'=>'0.75','upper_limit'=>'1.0','sign'=>'in_between'},vit_b7:{'lower_limit'=>'6.0','upper_limit'=>'9.0','sign'=>'in_between'},calcium:{'lower_limit'=>'150.0','upper_limit'=>'225.0','sign'=>'in_between'},iron:{'lower_limit'=>'2.85','upper_limit'=>'4.3','sign'=>'in_between'},magnesium:{'lower_limit'=>'58.0','upper_limit'=>'87.0','sign'=>'in_between'},zinc:{'lower_limit'=>'2.55','upper_limit'=>'3.83','sign'=>'in_between'},iodine:{'lower_limit'=>'22.5','upper_limit'=>'33.75','sign'=>'in_between'},potassium:{'lower_limit'=>'525.0','upper_limit'=>'787.5','sign'=>'in_between'},phosphorus:{'lower_limit'=>'150.0','upper_limit'=>'175.0','sign'=>'in_between'},manganese:{'lower_limit'=>'0.6','upper_limit'=>'0.9','sign'=>'in_between'},copper:{'lower_limit'=>'0.3','upper_limit'=>'0.45','sign'=>'in_between'},selenium:{'lower_limit'=>'6.0','upper_limit'=>'9.0','sign'=>'in_between'},chloride:{'lower_limit'=>'345.0','upper_limit'=>'517.0','sign'=>'in_between'},chromium:{'lower_limit'=>'7.5','upper_limit'=>'11.0','sign'=>'in_between'})

# BxBlockCheeseAndOil::MicroIngredient.create(point: 0.8, vit_a: { 'lower_limit' => '225.0','upper_limit'=>'300.0', 'sign' => 'in_between' },vit_c: { 'lower_limit' => '18.0','upper_limit'=>'24.0', 'sign' => 'in_between' }, vit_d: { 'lower_limit' => '3.375','upper_limit'=>'4.5' ,'sign' => 'in_between' },vit_b6:{'lower_limit'=>'0.428','upper_limit'=>'0.57','sign'=>'in_between'},vit_b12:{'lower_limit'=>'0.563','upper_limit'=>'0.75','sign'=>'in_between'},vit_b9:{'lower_limit'=>'67.5','upper_limit'=>'90.0','sign'=>'in_between'},vit_b2:{'lower_limit'=>'0.45','upper_limit'=>'0.6','sign'=>'in_between'},vit_b3:{'lower_limit'=>'3.1','upper_limit'=>'4.2','sign'=>'in_between'},vit_b1:{'lower_limit'=>'3.1','upper_limit'=>'4.326','sign'=>'in_between'},vit_b5:{'lower_limit'=>'1.0','upper_limit'=>'1.5','sign'=>'in_between'},vit_b7:{'lower_limit'=>'9.0','upper_limit'=>'12.0','sign'=>'in_between'},calcium:{'lower_limit'=>'225.0','upper_limit'=>'300.0','sign'=>'in_between'},iron:{'lower_limit'=>'4.3','upper_limit'=>'5.7','sign'=>'in_between'},magnesium:{'lower_limit'=>'87.0','upper_limit'=>'115.0','sign'=>'in_between'},zinc:{'lower_limit'=>'3.83','upper_limit'=>'5.1','sign'=>'in_between'},iodine:{'lower_limit'=>'33.75','upper_limit'=>'45','sign'=>'in_between'},potassium:{'lower_limit'=>'787.5','upper_limit'=>'1050.0','sign'=>'in_between'},phosphorus:{'lower_limit'=>'175.0','upper_limit'=>'300.0','sign'=>'in_between'},manganese:{'lower_limit'=>'0.9','upper_limit'=>'1.2','sign'=>'in_between'},copper:{'lower_limit'=>'0.45','upper_limit'=>'0.6','sign'=>'in_between'},selenium:{'lower_limit'=>'9.0','upper_limit'=>'12.0','sign'=>'in_between'},chloride:{'lower_limit'=>'517.0','upper_limit'=>'690','sign'=>'in_between'},chromium:{'lower_limit'=>'11.0','upper_limit'=>'15.0','sign'=>'in_between'})


# BxBlockCheeseAndOil::MicroIngredient.create(point: 1.0, vit_a: { 'value' => '300', 'sign' => 'greater_than' },vit_c: { 'value' => '24', 'sign' => 'greater_than' }, vit_d: { 'value' => '4.5', 'sign' => 'greater_than' }, vit_b6: { 'value' => '0.57', 'sign' => 'greater_than' }, vit_b12: { 'value' => '0.75', 'sign' => 'greater_than' }, vit_b9: { 'value' => '90', 'sign' => 'greater_than' }, vit_b2: { 'value' => '0.6', 'sign' => 'greater_than' }, vit_b3: { 'value' => '4.2', 'sign' => 'greater_than' }, vit_b1: { 'value' => '4.326', 'sign' => 'greater_than' }, vit_b5: { 'value' => '1.5', 'sign' => 'greater_than' }, vit_b7: { 'value' => '12', 'sign' => 'greater_than' }, calcium: { 'value' => '300', 'sign' => 'greater_than' }, iron: { 'value' => '5.7', 'sign' => 'greater_than' }, magnesium: { 'value' => '115', 'sign' => 'greater_than' }, zinc: { 'value' => '5.1', 'sign' => 'greater_than' }, iodine: { 'value' => '45', 'sign' => 'greater_than' }, potassium: { 'value' => '1050', 'sign' => 'greater_than' }, phosphorus: { 'value' => '300', 'sign' => 'greater_than' }, manganese: { 'value' => '1.2', 'sign' => 'greater_than' }, copper: { 'value' => '0.6', 'sign' => 'greater_than' }, selenium: { 'value' => '12', 'sign' => 'greater_than' }, chloride: { 'value' => '690', 'sign' => 'greater_than' }, chromium: { 'value' => '15', 'sign' => 'greater_than' })


# BxBlockBeverage::BeverageNegativeIngredient.create(point: 0.0, energy: { 'value' => '0', 'sign' => 'less_than_equals_to' },total_sugar: { 'value' => '0', 'sign' => 'less_than_equals_to' }, saturate: { 'value' => '1', 'sign' => 'less_than_equals_to' }, sodium: { 'value' => '90', 'sign' => 'less_than_equals_to' })

# BxBlockBeverage::BeverageNegativeIngredient.create(point: 1.0, energy: { 'value' => '7', 'sign' => 'less_than_equals_to' },total_sugar: { 'value' => '1.5', 'sign' => 'less_than_equals_to' }, saturate: { 'lower_limit' => '1.0','upper_limit'=>'2.0', 'sign' => 'in_between' }, sodium: { 'lower_limit' => '90.0','upper_limit'=>'180.0', 'sign' => 'in_between' })

# BxBlockBeverage::BeverageNegativeIngredient.create(point: 2.0, energy: { 'value' => '14', 'sign' => 'less_than_equals_to' },total_sugar: { 'value' => '3', 'sign' => 'less_than_equals_to' }, saturate: { 'lower_limit' => '2.0','upper_limit'=>'3.0', 'sign' => 'in_between' }, sodium: { 'lower_limit' => '180.0','upper_limit'=>'270.0' ,'sign' => 'in_between' })

# BxBlockBeverage::BeverageNegativeIngredient.create(point: 3.0, energy: { 'value' => '22', 'sign' => 'less_than_equals_to' },total_sugar: { 'value' => '4.5', 'sign' => 'less_than_equals_to' }, saturate: { 'lower_limit' => '3.0','upper_limit'=>'4.0', 'sign' => 'in_between'}, sodium: { 'lower_limit' => '270.0','upper_limit'=>'360.0', 'sign' => 'in_between' })

# BxBlockBeverage::BeverageNegativeIngredient.create(point: 4.0, energy: { 'value' => '29', 'sign' => 'less_than_equals_to' },total_sugar: { 'value' => '6', 'sign' => 'less_than_equals_to' }, saturate: { 'lower_limit' => '4.0','upper_limit'=>'5.0', 'sign' => 'in_between'}, sodium: { 'lower_limit' => '360.0','upper_limit'=>'450.0', 'sign' => 'in_between' })

# BxBlockBeverage::BeverageNegativeIngredient.create(point: 5.0, energy: { 'value' => '36', 'sign' => 'less_than_equals_to' },total_sugar: { 'value' => '7.5', 'sign' => 'less_than_equals_to' }, saturate: { 'lower_limit' => '5.0','upper_limit'=>'6.0', 'sign' => 'in_between'}, sodium: { 'lower_limit' => '450.0','upper_limit'=>'540.0', 'sign' => 'in_between' })

# BxBlockBeverage::BeverageNegativeIngredient.create(point: 6.0, energy: { 'value' => '43', 'sign' => 'less_than_equals_to' },total_sugar: { 'value' => '9', 'sign' => 'less_than_equals_to' }, saturate: { 'lower_limit' => '6.0','upper_limit'=>'7.0', 'sign' => 'in_between'}, sodium: { 'lower_limit' => '540.0','upper_limit'=>'630.0', 'sign' => 'in_between' })

# BxBlockBeverage::BeverageNegativeIngredient.create(point: 7.0, energy: { 'value' => '50', 'sign' => 'less_than_equals_to' },total_sugar: { 'value' => '10.5', 'sign' => 'less_than_equals_to' }, saturate: { 'lower_limit' => '7.0','upper_limit'=>'8.0', 'sign' => 'in_between'}, sodium: { 'lower_limit' => '630.0','upper_limit'=>'720.0', 'sign' => 'in_between' })

# BxBlockBeverage::BeverageNegativeIngredient.create(point: 8.0, energy: { 'value' => '57', 'sign' => 'less_than_equals_to' },total_sugar: { 'value' => '12', 'sign' => 'less_than_equals_to' }, saturate: { 'lower_limit' => '8.0','upper_limit'=>'9.0', 'sign' => 'in_between'}, sodium: { 'lower_limit' => '720.0','upper_limit'=>'810.0', 'sign' => 'in_between' })


# BxBlockBeverage::BeverageNegativeIngredient.create(point: 9.0, energy: { 'value' => '64', 'sign' => 'less_than_equals_to' },total_sugar: { 'value' => '13.5', 'sign' => 'less_than_equals_to' },saturate: { 'lower_limit' => '9.0','upper_limit'=>'10.0', 'sign' => 'in_between'}, sodium: { 'lower_limit' => '810.0','upper_limit'=>'900.0', 'sign' => 'in_between' })

# BxBlockBeverage::BeverageNegativeIngredient.create(point: 10.0, energy: { 'value' => '64', 'sign' => 'greater_than' },total_sugar: { 'value' => '13.5', 'sign' => 'greater_than' }, saturate: { 'value' => '10', 'sign' => 'greater_than' }, sodium: { 'value' => '900', 'sign' => 'greater_than' })

# BxBlockBeverage::BeveragePositiveIngredient.create(point: 0.0, fruit_veg: { 'value' => '40', 'sign' => 'less_than_equals_to' },fibre: { 'value' => '0.9', 'sign' => 'less_than_equals_to' }, protein: { 'value' => '1.6', 'sign' => 'less_than_equals_to' })

# BxBlockBeverage::BeveragePositiveIngredient.create(point: 1.0, fruit_veg: {}, fibre: { 'lower_limit' => '0.9','upper_limit'=>'1.9', 'sign' => 'in_between' },protein: { 'lower_limit' => '1.6','upper_limit'=>'3,2', 'sign' => 'in_between' })

# BxBlockBeverage::BeveragePositiveIngredient.create(point: 2.0,fruit_veg: { 'lower_limit' => '40', 'upper_limit' => '60', 'sign' => 'in_between' },  fibre: { 'lower_limit' => '1.9','upper_limit'=>'2.8', 'sign' => 'in_between' },protein: { 'lower_limit' => '3.2','upper_limit'=>'4.8', 'sign' => 'in_between' })


# BxBlockBeverage::BeveragePositiveIngredient.create(point: 3.0, fruit_veg: {},fibre: { 'lower_limit' => '2.8','upper_limit'=>'3.7', 'sign' => 'in_between' },protein: { 'lower_limit' => '4.8','upper_limit'=>'6.4', 'sign' => 'in_between' })

# BxBlockBeverage::BeveragePositiveIngredient.create(point: 4.0,fruit_veg: { 'lower_limit' => '60', 'upper_limit' => '80', 'sign' => 'in_between' },fibre: { 'lower_limit' => '3.7','upper_limit'=>'4.7', 'sign' => 'in_between' },protein: { 'lower_limit' => '6.4','upper_limit'=>'8', 'sign' => 'in_between' })

# BxBlockBeverage::BeveragePositiveIngredient.create(point: 5.0, fruit_veg: {}, fibre: { 'value' => '4.7', 'sign' => 'greater_than' },protein: { 'value' => '8', 'sign' => 'greater_than' })

# BxBlockBeverage::BeveragePositiveIngredient.create(point: 10.0, fruit_veg: { 'value' => '80', 'sign' => 'greater_than' }, fibre: {},protein: {})

# BxBlockBeverage::BeverageMicroIngredient.create(point: 0.0, vit_a: { 'value' => '25', 'sign' => 'less_than_equals_to' },vit_c: { 'value' => '2', 'sign' => 'less_than_equals_to' }, vit_d: { 'value' => '0.375', 'sign' => 'less_than_equals_to' }, vit_b6: { 'value' => '0.025', 'sign' => 'less_than_equals_to' }, vit_b12: { 'value' => '0.062', 'sign' => 'less_than_equals_to' }, vit_b9: { 'value' => '8', 'sign' => 'less_than_equals_to' }, vit_b2: { 'value' => '0.05', 'sign' => 'less_than_equals_to' }, vit_b3: { 'value' => '0.375', 'sign' => 'less_than_equals_to' }, vit_b1: { 'value' => '0.375', 'sign' => 'less_than_equals_to' }, vit_b5: { 'value' => '0.125', 'sign' => 'less_than_equals_to' }, vit_b7: { 'value' => '1', 'sign' => 'less_than_equals_to' }, calcium: { 'value' => '25', 'sign' => 'less_than_equals_to' }, iron: { 'value' => '0.5', 'sign' => 'less_than_equals_to' }, magnesium: { 'value' => '10', 'sign' => 'less_than_equals_to' }, zinc: { 'value' => '0.425', 'sign' => 'less_than_equals_to' }, iodine: { 'value' => '3.75', 'sign' => 'less_than_equals_to' }, potassium: { 'value' => '100', 'sign' => 'less_than_equals_to' }, phosphorus: { 'value' => '25', 'sign' => 'less_than_equals_to' }, manganese: { 'value' => '0.1', 'sign' => 'less_than_equals_to' }, copper: { 'value' => '0.05', 'sign' => 'less_than_equals_to' }, selenium: { 'value' => '1', 'sign' => 'less_than_equals_to' }, chloride: { 'value' => '62.5', 'sign' => 'less_than_equals_to' }, chromium: { 'value' => '1.5', 'sign' => 'less_than_equals_to' })

# BxBlockBeverage::BeverageMicroIngredient.create(point: 0.2, vit_a: { 'lower_limit' => '25.0','upper_limit'=>'50.0', 'sign' => 'in_between' },vit_c: { 'lower_limit' => '2.0','upper_limit'=>'4.0', 'sign' => 'in_between' }, vit_d: { 'lower_limit' => '0.375','upper_limit'=>'0.75' ,'sign' => 'in_between' },vit_b6:{'lower_limit'=>'0.025','upper_limit'=>'0.5','sign'=>'in_between'},vit_b12:{'lower_limit'=>'0.062','upper_limit'=>'0.125','sign'=>'in_between'},vit_b9:{'lower_limit'=>'8.0','upper_limit'=>'15.0','sign'=>'in_between'},vit_b2:{'lower_limit'=>'0.05','upper_limit'=>'0.1','sign'=>'in_between'},vit_b3:{'lower_limit'=>'0.375','upper_limit'=>'0.75','sign'=>'in_between'},vit_b1:{'lower_limit'=>'0.375','upper_limit'=>'0.75','sign'=>'in_between'},vit_b5:{'lower_limit'=>'0.125','upper_limit'=>'0.25','sign'=>'in_between'},vit_b7:{'lower_limit'=>'1.0','upper_limit'=>'2.0','sign'=>'in_between'},calcium:{'lower_limit'=>'25.0','upper_limit'=>'50.0','sign'=>'in_between'},iron:{'lower_limit'=>'0.5','upper_limit'=>'1.0','sign'=>'in_between'},magnesium:{'lower_limit'=>'10.0','upper_limit'=>'19.0','sign'=>'in_between'},zinc:{'lower_limit'=>'0.425','upper_limit'=>'0.85','sign'=>'in_between'},iodine:{'lower_limit'=>'3.75','upper_limit'=>'7.5','sign'=>'in_between'},potassium:{'lower_limit'=>'100.0','upper_limit'=>'200.0','sign'=>'in_between'},phosphorus:{'lower_limit'=>'25.0','upper_limit'=>'50.0','sign'=>'in_between'},manganese:{'lower_limit'=>'0.1','upper_limit'=>'0.2','sign'=>'in_between'},copper:{'lower_limit'=>'0.05','upper_limit'=>'0.1','sign'=>'in_between'},selenium:{'lower_limit'=>'1.0','upper_limit'=>'2.0','sign'=>'in_between'},chloride:{'lower_limit'=>'62.5','upper_limit'=>'125.0','sign'=>'in_between'},chromium:{'lower_limit'=>'1.5','upper_limit'=>'3.0','sign'=>'in_between'})
# BxBlockBeverage::BeverageMicroIngredient.create(point: 1.0, vit_a: { 'value' => '150', 'sign' => 'greater_than' },vit_c: { 'value' => '12', 'sign' => 'greater_than' }, vit_d: { 'value' => '2.25', 'sign' => 'greater_than' }, vit_b6: { 'value' => '0.285', 'sign' => 'greater_than' }, vit_b12: { 'value' => '0.375', 'sign' => 'greater_than' }, vit_b9: { 'value' => '45', 'sign' => 'greater_than' }, vit_b2: { 'value' => '0.3', 'sign' => 'greater_than' }, vit_b3: { 'value' => '2.1', 'sign' => 'greater_than' }, vit_b1: { 'value' => '2.16', 'sign' => 'greater_than' }, vit_b5: { 'value' => '0.75', 'sign' => 'greater_than' }, vit_b7: { 'value' => '6', 'sign' => 'greater_than' }, calcium: { 'value' => '150', 'sign' => 'greater_than' }, iron: { 'value' => '2.85', 'sign' => 'greater_than' }, magnesium: { 'value' => '58', 'sign' => 'greater_than' }, zinc: { 'value' => '2.55', 'sign' => 'greater_than' }, iodine: { 'value' => '22.5', 'sign' => 'greater_than' }, potassium: { 'value' => '525', 'sign' => 'greater_than' }, phosphorus: { 'value' => '150', 'sign' => 'greater_than' }, manganese: { 'value' => '0.6', 'sign' => 'greater_than' }, copper: { 'value' => '0.25', 'sign' => 'greater_than' }, selenium: { 'value' => '6', 'sign' => 'greater_than' }, chloride: { 'value' => '442.5', 'sign' => 'greater_than' }, chromium: { 'value' => '7.5', 'sign' => 'greater_than' })

# AdminUser.create!(email: 'ft@example.com', password: 'password', password_confirmation: 'password') unless AdminUser.find_by(email: 'ft@example.com')

# def calculation
# 	vitamins = 0
# 	energy_sum = 0
# 	fat_sum = 0
# 	sugar_sum = 0
# 	order_items = [4293, 4293, 4292, 4290, 4290]
# 	# as.each do |a|
# 		# order_items = self.order_items
#     products = BxBlockCatalogue::Product.includes(:ingredient).where(id: order_items.pluck(:product_id))
#     products.each do |product|
# 		byebug
#       nutrition = product.ingredient
#       energy_sum += nutrition.energy.to_f
#       fat_sum += nutrition.saturate.to_f
#       sugar_sum += nutrition.total_sugar.to_f
#       vitamins += nutrition.vit_a.to_f + nutrition.vit_c.to_f + nutrition.vit_d.to_f + nutrition.vit_b6.to_f + nutrition.vit_b12.to_f + nutrition.vit_b9.to_f + nutrition.vit_b2.to_f + nutrition.vit_b3.to_f + nutrition.vit_b1.to_f + nutrition.vit_b5.to_f + nutrition.vit_b7.to_f
#     end   
#     return  energy_sum, fat_sum, sugar_sum
# end	

# calculation 

# BxBlockCatalogue::Product.all.destroy_all
# BxBlockCatalogue::Ingredient.all.delete_all