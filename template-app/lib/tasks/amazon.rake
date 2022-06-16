namespace :amazon do
  
  task cycle: :environment do
    BxBlockScrappers::AmazonService.new.scrap_data
  	puts "Completed Amazon scraping"
  end
end
