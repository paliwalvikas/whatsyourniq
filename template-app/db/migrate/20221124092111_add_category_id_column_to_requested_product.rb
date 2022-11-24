class AddCategoryIdColumnToRequestedProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :requested_products, :category_id, :integer
  end
end
