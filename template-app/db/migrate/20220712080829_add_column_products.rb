class AddColumnProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :description, :text
    add_column :products, :ingredient_list, :text
    add_column :products, :food_drink_filter, :string
    add_column :products, :category_filter, :string
    add_column :products, :category_type_filter, :string
  end
end
