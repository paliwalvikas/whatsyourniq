class AddColumnToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :trans_fat, :float
  end
end
