class CreateImportStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :import_statuses do |t|
      t.string :job_id
      t.string :status, default: "In-Progress"
      t.text :file_status
      t.string :calculation_status
      t.string :file_name
      t.integer :record_file_contain
      t.integer :record_uploaded
      t.integer :record_failed

      t.timestamps
    end
  end
end
