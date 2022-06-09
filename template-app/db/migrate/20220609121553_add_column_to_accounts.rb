class AddColumnToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :full_name, :string
  end
end
