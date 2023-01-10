class AddColumnsToLanguage < ActiveRecord::Migration[6.0]
  def change
    add_column :languages, :language_type, :string
    add_column :languages, :locale, :string
    add_column :languages, :sequence, :bigint
  end
end
