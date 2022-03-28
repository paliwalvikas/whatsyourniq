class CreateBeverageNegeativeIngredient < ActiveRecord::Migration[6.0]
  def change
    create_table :beverage_negeative_ingredients do |t|
      t.float :point
      t.json :energy,  default: '{}'
      t.json :total_sugar,  default: '{}'
      t.json :saturate,  default: '{}'
      t.json :sodium,  default: '{}'

      t.timestamps
    end
  end
end
