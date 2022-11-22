class CreateReportedProductAnswer < ActiveRecord::Migration[6.0]
  def change
    create_table :reported_product_answers do |t|
      t.integer :reported_product_question_id
      t.text :reported_answer
      t.timestamps
    end
  end
end
