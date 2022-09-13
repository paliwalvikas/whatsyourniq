class CreateProductImportStatus < ActiveRecord::Migration[6.0]
  def change
    create_table :product_import_statuses do |t|
      t.string :job_id
      t.string :status, default: "In-Progress"

      t.timestamps
    end
  end
end
