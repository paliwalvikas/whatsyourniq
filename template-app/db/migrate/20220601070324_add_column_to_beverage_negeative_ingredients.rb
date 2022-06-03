class AddColumnToBeverageNegeativeIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :beverage_negeative_ingredients, :trans_fat, :float
  end
end
