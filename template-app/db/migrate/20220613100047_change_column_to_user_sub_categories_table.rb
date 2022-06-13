class ChangeColumnToUserSubCategoriesTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_sub_categories, :account_id, :integer, null: false 
    remove_column :user_sub_categories, :sub_category_id, :integer, null: false
  end   
  # def up
  #   add_column :user_sub_categories, :account_id, :integer
  #   add_column :user_sub_categories, :sub_category_id, :integer
  # end

  # def down
  #   remove_column :user_sub_categories, :account_id, :integer, null: false 
  #   remove_column :user_sub_categories, :sub_category_id, :integer, null: false
  # end
end
