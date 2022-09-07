class AddFolateColumnToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :folate, :string
  end
end
