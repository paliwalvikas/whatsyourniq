module AccountBlock
  class SocialAccountSerializer
    include FastJsonapi::ObjectSerializer

    attributes *[
      :full_name,
      :full_phone_number,
      :country_code,
      :phone_number,
      :email,
      :activated,
      :flag
    ]
  end
end
