class AddColumnToUserSubCategories < ActiveRecord::Migration[6.0]
  def change
    change_column :user_sub_categories, :account_id, :integer
    change_column :user_sub_categories, :sub_category_id, :integer
  end
end
