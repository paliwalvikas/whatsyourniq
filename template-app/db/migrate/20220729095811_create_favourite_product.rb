class CreateFavouriteProduct < ActiveRecord::Migration[6.0]
  def change
    create_table :favourite_products do |t|
      t.integer :account_id
      t.integer :product_id
      t.boolean :favourite, :boolean, default: false

      t.timestamps
    end
  end
end
