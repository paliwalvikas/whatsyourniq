class AddColumnToProductsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :description, :text
    add_column :products, :ingredient_list, :text
    add_column :products, :nutritional_information, :text
  end
end
