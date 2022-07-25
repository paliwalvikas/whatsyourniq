module AccountBlock
  class EmailAccountSerializer
    include FastJsonapi::ObjectSerializer

    attributes *[
      :first_name,
      :last_name,
      :full_phone_number,
      :country_code,
      :phone_number,
      :email,
      :activated,
    ]

    attribute :image do |object, _params|
      if object.image.attached?
        if Rails.env.development?
          Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true)
        else
          object.image&.service_url&.split('?')&.first
        end
      end
    end
  end
end
