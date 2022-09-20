class AddColumnCalculationStatusToProductImportStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :product_import_statuses, :calculation_status, :string
    add_column :product_import_statuses, :file_name, :string
  end
end
