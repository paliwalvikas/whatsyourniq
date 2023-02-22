class CreateFilterCategoryRange < ActiveRecord::Migration[6.0]
  def change
    create_table :filter_category_range do |t|
      t.integer :filter_category_id
      t.string :rang_for_a
      t.string :rang_for_b
      t.string :rang_for_c
      t.timestamps
    end
  end
end
