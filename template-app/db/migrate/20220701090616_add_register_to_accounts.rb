class AddRegisterToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :register, :boolean, default: false, null: false
  end
end
