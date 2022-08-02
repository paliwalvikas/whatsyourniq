class CreateCompareProduct < ActiveRecord::Migration[6.0]
  def change
    create_table :compare_products do |t|
      t.boolean :selected, default: false
      t.integer :account_id
      t.integer :product_id
      
      t.timestamps
    end
  end
end
