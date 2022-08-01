class AddRemoveColumnsFormIngredient < ActiveRecord::Migration[6.0]
  def change
    remove_column :ingredients, :calories , :string
    change_column :favourite_searches, :niq_score,:string, array: true, default: []
    change_column :favourite_searches, :food_allergies,:string, array: true, default: []
    change_column :favourite_searches, :food_preference,:string, array: true, default: []
    change_column :favourite_searches, :health_preference,:string, array: true, default: []
    # add_column :products, :add_favourite, :boolean, default: false
  end
end
