# frozen_string_literal: true

class AddColumnToAccountsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :gender, :string
    add_column :accounts, :age, :integer
  end
end
