class CreateTermsAndCondtions < ActiveRecord::Migration[6.0]
  def change
    create_table :terms_and_condtions do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
