class CreateChat < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
    	t.string :chat_type
    	t.string :question

    	t.timestamps
    end

    create_table :answer_options do |t|
			t.string :option
			t.integer :chat_id
			t.timestamps
		end

		create_table :chat_answers do |t| 
			t.integer :answer_option_id
    	t.integer :chat_id
    	t.integer :account_id
			t.string :answer

			t.timestamps
		end

  end
end
