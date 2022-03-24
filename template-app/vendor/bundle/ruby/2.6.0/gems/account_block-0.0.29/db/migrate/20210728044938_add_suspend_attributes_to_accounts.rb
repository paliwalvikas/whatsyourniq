class AddSuspendAttributesToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :suspend_until, :date
    add_column :accounts, :status, :integer, default: 0, null: false
  end
end
