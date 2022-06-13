class AddColumnToUserCategories < ActiveRecord::Migration[6.0]
  def change
    change_column :user_categories, :account_id, :integer
    change_column :user_categories, :category_id, :integer
  end
end
