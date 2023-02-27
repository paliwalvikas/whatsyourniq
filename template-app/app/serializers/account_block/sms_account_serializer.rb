module AccountBlock
  class SmsAccountSerializer
    include FastJsonapi::ObjectSerializer

    attributes *[
      :full_name,
      :full_phone_number,
      :country_code,
      :phone_number,
      :email,
      :gender,
      :activated,
      :device_id,
      :fb_social_id,
      :google_social_id
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
