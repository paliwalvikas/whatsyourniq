class AddCommentColumnToReportedProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :reported_products, :comment, :text
  end
end
