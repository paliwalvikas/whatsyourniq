module BxBlockCatalogue
  class ProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :product_name, :product_type, :product_point, :product_rating, :positive_good, :negative_not_good, :bar_code, :data_check, :food_drink_filter, :image, :category_type, :filter_category, :filter_sub_category, :description, :ingredient_list, :created_at, :updated_at
    
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
        _params[:good_ingredient].each do |val|
          val.flatten.last[:percent] = 100 if val.flatten.last[:percent] > 100
          object.positive_good.each do |column|
            if column.include?(val.first.to_s)
              val.flatten.last[:level] = column
              break
            else
              val.flatten.last[:level] = nil
            end
          end
        end
        # _params[:good_ingredient].merge(object.vitamins_and_minrals)
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
