class AddCategoryTypeColumnToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :category_type, :integer
    remove_column :categories, :admin_user_id
    remove_column :categories, :rank
    remove_column :categories, :light_icon
    remove_column :categories, :light_icon_active
    remove_column :categories, :light_icon_inactive
    remove_column :categories, :dark_icon
    remove_column :categories, :dark_icon_active
    remove_column :categories, :identifier

  end
end
