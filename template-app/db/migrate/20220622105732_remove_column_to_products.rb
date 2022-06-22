class RemoveColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :ingredient_list, :text
    remove_column :products, :nutritional_information, :text
    remove_column :products, :description, :text
  end
end
