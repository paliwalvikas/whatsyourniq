class ChangeDataTypeForAddProfileColumns < ActiveRecord::Migration[6.0]
  def change
    change_column :add_profiles, :weight, :float
    change_column :add_profiles, :height, :float
  end
end
