class AddColumnsToAddProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :add_profiles, :bmi_result, :float
    add_column :add_profiles, :bmi_status, :integer
  end
end
