class AddColumnToSmsOtp < ActiveRecord::Migration[6.0]
  def change
    add_column :sms_otps, :hash_key, :string
  end
end
