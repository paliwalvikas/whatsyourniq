class AddAdditionalDetailsInAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :additional_details, :boolean, default: false
  end
end
