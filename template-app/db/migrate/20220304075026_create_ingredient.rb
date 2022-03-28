class CreateIngredient < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.integer :product_id
      t.string :energy
      t.string :saturate
      t.string :total_sugar
      t.string :sodium
      t.string :ratio_fatty_acid_lipids
      t.string :fruit_veg
      t.string  :fibre
      t.string :protein
      t.string :vit_a
      t.string :vit_c
      t.string :vit_d
      t.string :vit_b6
      t.string :vit_b12
      t.string :vit_b9
      t.string :vit_b2
      t.string :vit_b3
      t.string :vit_b1
      t.string :vit_b5
      t.string :vit_b7
      t.string :calcium
      t.string :iron
      t.string :magnesium
      t.string :zinc
      t.string :iodine
      t.string :potassium
      t.string :phosphorus
      t.string :manganese
      t.string :copper
      t.string :selenium
      t.string :chloride
      t.string :chromium

      t.timestamps 
    end
  end
end
