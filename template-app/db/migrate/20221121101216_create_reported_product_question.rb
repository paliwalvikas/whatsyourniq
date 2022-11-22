class CreateReportedProductQuestion < ActiveRecord::Migration[6.0]
  def change
    create_table :reported_product_questions do |t|
      t.text :reported_question
      t.timestamps
    end
  end
end
