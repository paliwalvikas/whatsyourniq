# frozen_string_literal: true

module BxBlockCatalogue
  class RequestedProductSerializer < BuilderBase::BaseSerializer
    attributes :name, :weight, :status, :refernce_url, :category, :created_at, :updated_at

    attribute :product_image do |object, params|
      host = params[:host] || ''
      if object.product_image.attached?
        object.product_image.map do |image|
          {
            id: image.id,
            url: if Rails.env.development?
                   (host + Rails.application.routes.url_helpers.rails_blob_url(image,
                                                                               only_path: true))
                 else
                   image.service_url
                 end
          }
        end
      end
    end

    attribute :barcode_image do |object, params|
      host = params[:host] || ''
      if object.barcode_image.attached?
        object.barcode_image.map do |image|
          {
            id: image.id,
            url: if Rails.env.development?
                   (host + Rails.application.routes.url_helpers.rails_blob_url(image,
                                                                               only_path: true))
                 else
                   image.service_url
                 end
          }
        end
      end
    end
  end
end
