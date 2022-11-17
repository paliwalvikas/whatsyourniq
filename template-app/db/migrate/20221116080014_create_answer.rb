class CreateAnswer < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
    	t.text :answer 
    	t.integer :faq_id

    	t.timestamps
    end
  end
end
