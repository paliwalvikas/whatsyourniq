module BxBlockCatalogue
  class ProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :product_name, :product_type, :product_rating, :product_point, :positive_good, :negative_not_good, :bar_code, :data_check, :food_drink_filter, :image, :category_type, :filter_category, :filter_sub_category, :description, :ingredient_list, :created_at, :updated_at
    
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
      object.category&.category_type&.titleize
    end

    attribute :product_rating do |object|
      object.product_rating.present? ? object.product_rating : "NA"
    end

    attribute :product_point do |object|
      object.product_point.present? ? object.product_point : "NA"
    end

    attributes :compare_product do |object, user|
      if user[:user].present?
        compare = user[:user].compare_products.where(selected: true, product_id: object.id)
        compare.present? 
      else
        false
      end
    end

    attribute :filter_category do |object|
      object.filter_category.name.titleize
    end

    attribute :filter_sub_category do |object|
      object.filter_sub_category.name.titleize
    end

    attribute :positive_good do |object, _params|
      if _params[:good_ingredient].present? 
        _params[:good_ingredient]
      end
    end

    attribute :negative_not_good do |object, _params|
      if _params[:not_so_good_ingredient].present?
        _params[:not_so_good_ingredient]
      end
    end
  end
end
