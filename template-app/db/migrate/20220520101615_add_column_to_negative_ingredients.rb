class AddColumnToNegativeIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :negative_ingredients, :trans_fat, :float
  end
end
