class AddIngredients < ActiveRecord::Migration[6.0]
  def change
  	add_column :ingredients, :dairy, :string
  	add_column :ingredients, :vit_e, :string
  	add_column :ingredients, :omega_3, :string
  	add_column :ingredients, :d_h_a , :string
  	add_column :ingredients, :no_artificial_color, :string
  	add_column :ingredients, :calories , :string
  end
end
