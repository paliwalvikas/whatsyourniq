class AddScraping < ActiveRecord::Migration[6.0]
  def change
  	BxBlockScrappers::BigBasketService.new.scrap_data
  end
end
