class ToChangeDataTypeBarCode < ActiveRecord::Migration[6.0]
  def change
  	change_column :products, :bar_code, :string
  end
end
