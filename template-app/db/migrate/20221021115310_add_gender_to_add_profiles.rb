class AddGenderToAddProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :add_profiles, :gender, :integer
  end
end
