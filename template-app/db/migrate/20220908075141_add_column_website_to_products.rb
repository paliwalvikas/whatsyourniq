class AddColumnWebsiteToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :website, :string
  end
end
