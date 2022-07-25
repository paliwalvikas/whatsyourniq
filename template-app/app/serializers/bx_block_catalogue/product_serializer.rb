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
      object.category.category_type.titleize
    end

    attribute :positive_good do |object, _params|
      if _params[:good_ingredient].present?
        _params[:good_ingredient].each do |val|
          val.flatten.last[:percent] = 100 if val.flatten.last[:percent] > 100
          object.positive_good.each do |column|
            key = val.first.to_s.include?('vit') ? 'vit' : val.first.to_s
            if column.include?(key)
              val.flatten.last[:level] = column
              break
            else
             val.flatten.last[:level] = nil
            end
          end
        end
      end
    end

    attribute :negative_not_good do |object, _params|
      if _params[:not_so_good_ingredient].present?
        _params[:not_so_good_ingredient].each do |val|
          val.flatten.last[:percent] = 100 if val.flatten.last[:percent] > 100
          object.negative_not_good.each do |column|
            if column.include?(val.first.to_s)
              val.flatten.last[:level] = column
              break
            else
              val.flatten.last[:level] = nil
            end
          end
        end
      end
    end
    
  end
end
