class CreateFavouriteSearch < ActiveRecord::Migration[6.0]
  def change
    create_table :favourite_searches do |t|
    	t.integer :category_id #food_type
    	t.json :product_category
    	t.json :product_sub_category
    	t.integer :niq_score,array: true, default: []
    	t.integer :food_allergies, array: true, default: []
    	t.integer :food_preference, array: true, default: []
    	t.json :functional_preference #functional preference
    	t.integer :health_preference, array: true, default: []
      t.boolean :favourite, default: false
      t.integer :account_id
      t.integer :product_count

    	t.timestamps
    end
  end
end
