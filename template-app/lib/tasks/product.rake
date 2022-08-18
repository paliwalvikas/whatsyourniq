# frozen_string_literal: true

namespace :Product do
  desc 'Niq Score Update'
  task niq: :environment do
    count = 0
    BxBlockCatalogue::Product.find_in_batches do |products|
      products.each do |product|
        product.calculation
        count += 1
      end
    end
    puts "#{count} Products Niq Score Updated Successfully"
  end
end
