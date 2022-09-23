class AddColumnCalculatedToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :calculated, :boolean, default: false
    add_column :products, :np_calculated, :boolean, default: false
  end
end
