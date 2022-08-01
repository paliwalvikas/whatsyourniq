# frozen_string_literal: true

class CreateFilterCategory < ActiveRecord::Migration[6.0]
  def change
    create_table :filter_categories do |t|
      t.string :name
      t.timestamps
    end

    create_table :filter_sub_categories do |t|
      t.string :name
      t.integer :filter_category_id
      t.timestamps
    end
  end
end
