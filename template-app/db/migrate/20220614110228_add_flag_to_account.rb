class AddFlagToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :flag, :boolean, default: false, null: false
  end
end
