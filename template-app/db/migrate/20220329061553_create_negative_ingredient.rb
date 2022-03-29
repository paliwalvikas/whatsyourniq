class CreateNegativeIngredient < ActiveRecord::Migration[6.0]
  def change
    create_table :negative_ingredients do |t|
      t.float :point
      t.json :energy,  default: '{}'
      t.json :total_sugar,  default: '{}'
      t.json :saturate,  default: '{}'
      t.json :sodium,  default: '{}'
      t.json :ratio_fatty_acid_lipids,  default: '{}'

      t.timestamps
    end
  end
end
