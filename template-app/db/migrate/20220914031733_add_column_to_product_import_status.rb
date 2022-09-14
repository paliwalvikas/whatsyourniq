class AddColumnToProductImportStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :product_import_statuses, :record_file_contain, :integer
    add_column :product_import_statuses, :record_uploaded, :integer
    add_column :product_import_statuses, :record_failed, :integer
  end
end
