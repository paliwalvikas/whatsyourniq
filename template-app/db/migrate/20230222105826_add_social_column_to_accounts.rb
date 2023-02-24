class AddSocialColumnToAccounts < ActiveRecord::Migration[6.0]
  def change
  	add_column :accounts, :fb_social_id, :string
    add_column :accounts, :google_social_id, :string
  end
end
