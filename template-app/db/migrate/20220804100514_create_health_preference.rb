  class CreateHealthPreference < ActiveRecord::Migration[6.0]
  def change
    create_table :health_preferences do |t|
      t.boolean :immunity, default: false
      t.boolean :gut_health, default: false
      t.boolean :holistic_nutrition, default: false
      t.boolean :weight_loss, default: false
      t.boolean :weight_gain, default: false
      t.boolean :diabetic, default: false
      t.boolean :low_cholestrol, default: false
      t.boolean :heart_friendly, default: false
      t.boolean :energy_and_vitality, default: false
      t.boolean :physical_growth, default: false
      t.boolean :cognitive_health, default: false
      t.boolean :high_protein , default: false
      t.boolean :low_sugar , default: false
      t.integer :product_id

      t.timestamps
    end
  end
end
