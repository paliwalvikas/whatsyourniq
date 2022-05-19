class RemoveColumnToCategories < ActiveRecord::Migration[6.0]
  def change
    remove_column :categories, :dark_icon_inactive, :string 
  end
end
