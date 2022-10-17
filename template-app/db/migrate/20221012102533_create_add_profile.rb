class CreateAddProfile < ActiveRecord::Migration[6.0]
  def change
    create_table :relations do |t|
      t.string :relation

      t.timestamps
    end

    create_table :add_profiles do |t|
      t.string :full_name
      t.integer :weight
      t.integer :height
      t.integer :age
      t.string :email
      t.bigint :contact_no
      t.string :address
      t.string :pincode

      t.integer :relation_id

      t.integer :account_id 
      t.integer :activity_level
      t.string :state
      t.string :city 

      t.timestamps
    end

  end
end
