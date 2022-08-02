class ChnageColumnsFavSearch < ActiveRecord::Migration[6.0]
  def change
    remove_column :favourite_searches, :category_id 
    change_column :favourite_searches, :health_preference, :string, default: nil
    add_column :favourite_searches, :added_count, :integer, default: 0
    add_column :favourite_searches, :food_type, :string, array: true, default: []
  end
end
