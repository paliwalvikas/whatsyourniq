class AddColumnToProduct < ActiveRecord::Migration[6.0]
  def change
     add_column :products, :weight, :string
     add_column :products, :price_mrp, :integer
     add_column :products, :price_post_discount, :integer
     add_column :products, :brand_name, :string
  end
end
