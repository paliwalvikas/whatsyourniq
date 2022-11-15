module BxBlockCatalogue
  class RequestedProductSerializer < BuilderBase::BaseSerializer
    attributes :name, :weight, :status

    attribute :product_image do |object, params|
      host = params[:host] || ''
      if object.product_image.attached?
        object.product_image.map { |image|
          {
              id: image.id,
              url: Rails.env.development? ? (host + Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)) : image.service_url
          }
        }
      end
    end

    attribute :barcode_image do |object, params|
      host = params[:host] || ''
      if object.barcode_image.attached?
        object.barcode_image.map { |image|
          {
              id: image.id,
              url: Rails.env.development? ? (host + Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)) : image.service_url
          }
        }
      end
    end
  end
end