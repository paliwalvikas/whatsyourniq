class ChangeColumnToContactUs < ActiveRecord::Migration[6.0]
  def change
    rename_column :contact_us, :type, :contact_type
  end
end
