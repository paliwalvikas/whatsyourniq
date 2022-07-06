class AddCategoryId < ActiveRecord::Migration[6.0]
  def change
    if ENV['STAGING_URL']
      BxBlockCatalogue::Product.all.each do |product|
        product.update_columns(category_id: 3)
      end
    end  
  end
end
