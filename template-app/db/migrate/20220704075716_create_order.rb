class CreateOrder < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :account_id
      t.string :order_name
      t.timestamps
    end
  end
end
