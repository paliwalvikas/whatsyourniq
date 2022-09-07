class AddColumnToImportProductStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :product_import_statuses, :file_status, :text
  end
end
