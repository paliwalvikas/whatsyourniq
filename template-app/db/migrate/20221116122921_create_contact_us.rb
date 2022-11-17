class CreateContactUs < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_us do |t|
    	t.integer :type
    	t.string :business_name
    	t.string :name
    	t.string :email
    	t.bigint :contact_no
    	t.text :message

    	t.timestamps
    end
  end
end
