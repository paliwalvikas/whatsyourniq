class CreateProduct < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.integer :product_type
      t.float :product_point
      t.string :product_rating
      t.timestamps
    end
  end
end
