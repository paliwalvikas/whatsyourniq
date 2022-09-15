class AddFatToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :fat, :string
  end
end
