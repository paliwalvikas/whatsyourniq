class AddColumnIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :carbohydrate, :string 
    add_column :ingredients, :total_fat, :string
    add_column :ingredients, :monosaturated_fat, :string
    add_column :ingredients, :polyunsaturated_fat, :string
    add_column :ingredients, :fatty_acid, :string
    add_column :ingredients, :mono_unsaturated_fat, :string
    add_column :ingredients, :veg_and_nonveg, :string
    add_column :ingredients, :gluteen_free, :string
    add_column :ingredients, :added_sugar, :string
    add_column :ingredients, :artificial_preservative, :string
    add_column :ingredients, :organic, :string
    add_column :ingredients, :vegan_product, :string 
    add_column :ingredients, :egg, :string
    add_column :ingredients, :fish, :string
    add_column :ingredients, :shellfish, :string 
    add_column :ingredients, :tree_nuts, :string
    add_column :ingredients, :peanuts, :string
    add_column :ingredients, :wheat, :string
    add_column :ingredients, :soyabean, :string 
    add_column :ingredients, :cholestrol, :string
  end
end
