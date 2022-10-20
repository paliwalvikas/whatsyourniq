module BxBlockAddProfile
  class AddProfileSerializer < BuilderBase::BaseSerializer
    attributes :id, :full_name, :age, :weight, :height, :contact_no, :email, :city, :state, :activity_level, :address, :pincode, :created_at, :updated_at

    attributes :relation do |object|
      object&.relation&.relation
    end

    attributes :account do |object|
      AccountBlock::AccountSerializer.new(object.account)
    end

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
