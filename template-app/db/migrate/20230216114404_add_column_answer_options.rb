class AddColumnAnswerOptions < ActiveRecord::Migration[6.0]
  def change
  	add_column :answer_options, :message, :string
  	add_column :answer_options, :marks, :float, default: 0.0
  end
end
