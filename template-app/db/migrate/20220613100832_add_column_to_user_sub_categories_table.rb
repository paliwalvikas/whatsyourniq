class AddColumnToUserSubCategoriesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :user_sub_categories, :account_id, :integer
    add_column :user_sub_categories, :sub_category_id, :integer
  end
end
