class CreateFaq < ActiveRecord::Migration[6.0]
  def change
    create_table :faqs do |t|
    	t.string :question

    	t.timestamps
    end
  end
end
