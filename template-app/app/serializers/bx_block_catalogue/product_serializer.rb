module BxBlockCatalogue
  class ProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :product_name, :product_type, :product_point, :product_rating, :positive_good, :negative_not_good, :bar_code, :data_check, :created_at, :updated_at
    
    attribute :image do |object, _params|
      if object.image.attached?
        if Rails.env.development?
          Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true)
        else
          object.image&.service_url&.split('?')&.first
        end
      end
    end
    
    attribute :category_type do |object|
      object.category.category_type.gsub('_', ' ').titleize
    end
  end
end
