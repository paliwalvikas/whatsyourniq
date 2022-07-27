module BxBlockCatalogue
  class Order < BxBlockCatalogue::ApplicationRecord
    self.table_name = :orders
    belongs_to :account, class_name: 'AccountBlock::Account'
    has_many :order_items, class_name: 'BxBlockCatalogue::OrderItem', dependent: :destroy 

    def order_product_calculation
      energy_sum,fat_sum, sugar_sum, vitamins, minerals = 0,0,0,0,0
      order_items = self.order_items
      products = BxBlockCatalogue::Product.includes(:ingredient).where(id: order_items.pluck(:product_id))
      products.each do |product|
        nutrition = product.ingredient
        energy_sum += nutrition.energy.to_f
        fat_sum += nutrition.saturate.to_f
        sugar_sum += nutrition.total_sugar.to_f
        vitamins += (nutrition.vit_a.to_f + nutrition.vit_c.to_f + nutrition.vit_d.to_f + nutrition.vit_b6.to_f + nutrition.vit_b12.to_f + nutrition.vit_b9.to_f + nutrition.vit_b2.to_f + nutrition.vit_b3.to_f + nutrition.vit_b1.to_f + nutrition.vit_b5.to_f + nutrition.vit_b7.to_f)
        minerals += (nutrition.calcium.to_f + nutrition.iron.to_f + nutrition.magnesium.to_f + nutrition.zinc.to_f + nutrition.iodine.to_f + nutrition.potassium.to_f + nutrition.phosphorus.to_f + nutrition.manganese.to_f + nutrition.copper.to_f + nutrition.selenium.to_f + nutrition.chloride.to_f + nutrition.chromium.to_f)
      end  
      positive_points =  (energy_sum + vitamins + minerals)
      negative_points =  (fat_sum + sugar_sum)

      return  { positive: {energy: energy_sum.round(2), vitamin: vitamins.round(2), minerals: minerals.round(2)},negative: {fat: fat_sum.round(2), sugar: sugar_sum.round(2),},positive_points: positive_points.round(2),  negative_points: negative_points.round(2) }
    end 


  end
end

