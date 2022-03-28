class CreateBeveragePositiveIngredient < ActiveRecord::Migration[6.0]
  def change
    create_table :beverage_positive_ingredients do |t|
      t.float :point
      t.json :fruit_veg, default: '{}'
      t.json :fibre,  default: '{}'
      t.json  :protein,  default: '{}'

      t.timestamps 
    end
  end
end
