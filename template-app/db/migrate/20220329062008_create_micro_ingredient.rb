class CreateMicroIngredient < ActiveRecord::Migration[6.0]
  def change
    create_table :micro_ingredients do |t|
      t.float :point
      t.json :vit_a,  default: '{}' 
      t.json :vit_c,  default: '{}'
      t.json :vit_d,  default: '{}'
      t.json :vit_b6,  default: '{}'
      t.json :vit_b12,  default: '{}'
      t.json :vit_b9,  default: '{}'
      t.json :vit_b2,  default: '{}'
      t.json :vit_b3,  default: '{}'
      t.json :vit_b1,  default: '{}'
      t.json :vit_b5,  default: '{}'
      t.json :vit_b7,  default: '{}'
      t.json :calcium,  default: '{}'
      t.json :iron,  default: '{}'
      t.json :magnesium,  default: '{}'
      t.json :zinc,  default: '{}'
      t.json :iodine,  default: '{}'
      t.json :potassium,  default: '{}'
      t.json :phosphorus,  default: '{}'
      t.json :manganese,  default: '{}'
      t.json :copper,  default: '{}'
      t.json :selenium,  default: '{}'
      t.json :chloride,  default: '{}'
      t.json :chromium,  default: '{}'

      t.timestamps
    end
  end
end
