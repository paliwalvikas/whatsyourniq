class CreateAboutContents < ActiveRecord::Migration[6.0]
  def change
    create_table :about_contents do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
