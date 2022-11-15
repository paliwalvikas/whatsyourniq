class CreateRequestedProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :requested_products do |t|
      t.integer :account_id
      t.string :name
      t.string :weight
      t.string :refernce_url
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
