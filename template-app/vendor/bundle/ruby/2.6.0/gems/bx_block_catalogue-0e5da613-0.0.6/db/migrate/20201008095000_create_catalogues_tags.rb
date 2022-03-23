class CreateCataloguesTags < ActiveRecord::Migration[6.0]
  def change
    create_table :catalogues_tags do |t|
      t.references :catalogue, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
    end
  end
end
