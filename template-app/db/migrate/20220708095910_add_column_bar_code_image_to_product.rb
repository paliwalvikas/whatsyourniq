class AddColumnBarCodeImageToProduct < ActiveRecord::Migration[6.0]
   def change
    add_column :products, :images, :text, array: true, default: []
    add_column :products, :bar_code, :integer
    add_column :products , :data_check, :string

  end
end
