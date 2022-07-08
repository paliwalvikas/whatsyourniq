class To < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :images, :text, array: true, default: []
    add_column :products, :image, :text, array: true, default: []
  end
end
