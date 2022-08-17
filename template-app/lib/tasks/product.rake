# frozen_string_literal: true

namespace :Product do
  desc 'Niq Score Update'
  task niq: :environment do
    BxBlockCatalogue::Product.all.map { |product| product.calculation }
    puts 'Niq Score Updated Successfully'
  end
end
