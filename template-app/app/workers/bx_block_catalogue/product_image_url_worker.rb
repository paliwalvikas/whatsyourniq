# frozen_string_literal: true

module BxBlockCatalogue
  class ProductImageUrlWorker
    include Sidekiq::Worker
    include Sidekiq::Status::Worker
    sidekiq_options retry: 3

    def perform
      BxBlockCatalogue::Product.where(data_check: 'green').in_batches.each do |products|
        products.each do |object|
          next unless object.image.attached?

          image = if Rails.env.development?
                    Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true)
                  else
                    object.image&.service_url&.split('?')&.first
                  end
          object.update_columns(image_url: image)
        end
      end
    end
  end
end
