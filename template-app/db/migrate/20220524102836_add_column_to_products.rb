class AddColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :positive_good, :text, array: true, default: []
    add_column :products, :negative_not_good, :text, array: true, default: []
  end
end
