class AddAccountIdColumnToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :account_id, :integer
  end
end
