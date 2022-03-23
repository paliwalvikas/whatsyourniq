class CreateBxBlockLanguageoptionsLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :language_code
      t.boolean :is_content_language
      t.boolean :is_app_language

      t.timestamps
    end
  end
end
