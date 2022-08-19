class AddIndexToProduct < ActiveRecord::Migration[6.0]
  def change
    add_index :products, :category_id
    add_index :products, :filter_sub_category_id
    add_index :products, :filter_category_id

  end
end
