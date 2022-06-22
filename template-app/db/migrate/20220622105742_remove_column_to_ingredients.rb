class RemoveColumnToIngredients < ActiveRecord::Migration[6.0]
  def change
    remove_column :ingredients, :carbohydrat, :string
    remove_column :ingredients, :total_fat, :string
    remove_column :ingredients, :cholestrol, :string
    remove_column :ingredients, :data_check, :string
    remove_column :ingredients, :gluteen_free, :string
    remove_column :ingredients, :added_sugar, :string
    remove_column :ingredients, :artificial_preservative , :string
    remove_column :ingredients, :vegan_product, :string
    remove_column :ingredients, :egg, :string
    remove_column :ingredients, :fish, :string
    remove_column :ingredients, :organic, :string
  end
end
