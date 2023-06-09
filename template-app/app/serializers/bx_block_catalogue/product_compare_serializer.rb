# frozen_string_literal: true

module BxBlockCatalogue
  class ProductCompareSerializer < BuilderBase::BaseSerializer
    attributes :id, :product_name, :product_type, :product_rating, :product_point, :positive_good, :negative_not_good,
               :bar_code, :data_check, :food_drink_filter, :image, :category_type, :filter_category, :filter_sub_category, :description, :ingredient_list, :created_at, :updated_at

    attribute :image do |object, _params|
      if _params[:status] == 'offline'
        nil
      else
        if object.image.attached?
          if Rails.env.development?
            Rails.application.routes.url_helpers.rails_blob_path(object.image, only_path: true)
          else
            object.image&.service_url&.split('?')&.first
          end
        end
      end
    end

    attribute :category_type do |object|
      object.category&.category_type&.titleize
    end

    attribute :product_rating do |object|
      object.product_rating.present? ? object.product_rating : 'NA'
    end

    attribute :product_point do |object|
      object.product_point.present? ? object.product_point : 'NA'
    end

    attributes :compare_product do |object, user|
      if user[:user].present?
        compare = user[:user].compare_products.where(selected: true, product_id: object.id)
        compare.present?
      else
        false
      end
    end

    attribute :added_to_fav do |object, user|
      if user[:user].present?
        compare = user[:user].favourite_products.where(product_id: object.id)
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
      if _params[:status] == 'offline' && object.rda_value.present?
        object.rda_value['good_ingredient'].each do |gi|
          gi[:level] = I18n.t("models.bx_block_catalogue.products.data.level.#{gi[:level]}")
          gi[:name] = I18n.t("models.bx_block_catalogue.products.data.name.#{gi[:name]}")
        end
      elsif _params[:good_ingredient].present?
        _params[:good_ingredient].each do |gi|
          gi[:level] = I18n.t("models.bx_block_catalogue.products.data.level.#{gi[:level]}")
          gi[:name] = I18n.t("models.bx_block_catalogue.products.data.name.#{gi[:name]}")
        end
      end
    end

    attribute :health_preference do |obj, _params| 
      _params[:health_preference]
    end

    attribute :negative_not_good do |object, _params|
      if _params[:status] == 'offline' && object.rda_value.present?
        object.rda_value['not_so_good_ingredient'].each do |ngi|
          ngi[:level] = I18n.t("models.bx_block_catalogue.products.data.level.#{ngi[:level]}")
          ngi[:name] = I18n.t("models.bx_block_catalogue.products.data.name.#{ngi[:name]}")
        end
      elsif _params[:not_so_good_ingredient].present?
        _params[:not_so_good_ingredient].each do |ngi|
          ngi[:level] = I18n.t("models.bx_block_catalogue.products.data.level.#{ngi[:level]}")
          ngi[:name] = I18n.t("models.bx_block_catalogue.products.data.name.#{ngi[:name]}")
        end
      end
    end
  end
end
