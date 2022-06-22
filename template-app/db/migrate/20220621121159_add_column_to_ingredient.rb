class AddColumnToIngredient < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :carbohydrat, :string
    add_column :ingredients, :total_fat, :string
    add_column :ingredients, :cholestrol, :string
    add_column :ingredients, :data_check, :string
    add_column :ingredients, :gluteen_free, :string
    add_column :ingredients, :added_sugar, :string
    add_column :ingredients, :artificial_preservative , :string
    add_column :ingredients, :vegan_product, :string
    add_column :ingredients, :egg, :string
    add_column :ingredients, :fish, :string
    add_column :ingredients, :organic, :string
  end
end
