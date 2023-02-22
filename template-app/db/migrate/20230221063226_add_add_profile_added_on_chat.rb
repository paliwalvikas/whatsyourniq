class AddAddProfileAddedOnChat < ActiveRecord::Migration[6.0]
  def change
  	add_column :chat_answers, :add_profile_id, :integer
  	add_column :accounts, :weight, :float, default: 0.0
  	add_column :accounts, :height, :float, default: 0.0
  	add_column :accounts, :bmi_result, :float, default: 0.0
  	add_column :accounts, :bmi_status, :integer, default: 0
  end
end
