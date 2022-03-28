ActiveAdmin.register BxBlockCatalogue::Ingredient do
  permit_params :id, :product_id, :ingredients,:energy,:saturate,:total_sugar,:sodium,:ratio_fatty_acid_lipids,:fruit_veg,:protein,:vit_a,:vit_c,:vit_d,:vit_b6,:vit_b12,:vit_b9,:vit_b2,:vit_b3,:vit_b1,:vit_b5,:vit_b7,:calcium,:iron,:magnesium,:zinc,:iodine,:potassium,:phosphorus,:manganese,:copper,:selenium,:chloride,:chromium
end