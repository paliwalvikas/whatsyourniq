class CreateLogedFood < ActiveRecord::Migration[6.0]
  def change
    create_table :loged_foods do |t|
      t.integer :account_id
      t.integer :food_type
      t.datetime :default_time
      t.integer :product_id
      t.string :quantity 
    end
  end
end
