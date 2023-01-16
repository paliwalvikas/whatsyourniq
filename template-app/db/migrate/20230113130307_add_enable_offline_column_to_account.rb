class AddEnableOfflineColumnToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :enable_offline, :boolean
  end
end
