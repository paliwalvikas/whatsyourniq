class CreateReportedProduct < ActiveRecord::Migration[6.0]
  def change
    create_table :reported_products do |t|
      t.integer :product_id
      t.integer :account_id
      t.text :description
      t.integer :ans_ids, array: true, default: []
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
