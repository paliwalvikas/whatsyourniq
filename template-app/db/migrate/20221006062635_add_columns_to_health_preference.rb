class AddColumnsToHealthPreference < ActiveRecord::Migration[6.0]
  def change
    add_column :health_preferences, :hyperthyroid, :boolean ,default: false
    add_column :health_preferences, :greater_than_60_years_old, :boolean ,default: false
    add_column :health_preferences, :pregnant_women, :boolean ,default: false
    add_column :health_preferences, :hypothyroid, :boolean ,default: false
    add_column :ingredients, :jain, :string 
  end
end
