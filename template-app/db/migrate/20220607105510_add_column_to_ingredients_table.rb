class AddColumnToIngredientsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :probiotic, :float
  end
end
