class AddRdaValueColumnToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :rda_value, :json
  end
end
