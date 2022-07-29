# frozen_string_literal: true

class AddColumnsNameToProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :category_filter, :string
    remove_column :products, :category_type_filter, :string
    remove_column :products, :food_drink_filter, :string

    add_column :products, :filter_category_id, :integer
    add_column :products, :filter_sub_category_id, :integer
    add_column :products, :food_drink_filter, :integer
  end
end
