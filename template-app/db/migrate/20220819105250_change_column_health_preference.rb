class ChangeColumnHealthPreference < ActiveRecord::Migration[6.0]
  def change
    rename_column :health_preferences, :low_cholestrol, :low_cholesterol
  end
end
