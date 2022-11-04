# frozen_string_literal: true

module AccountBlock
  class AccountSerializer < BuilderBase::BaseSerializer
    attributes(:activated, :country_code, :email, :full_name, :type,
               :created_at, :updated_at, :device_id, :unique_auth_id, :gender)

    attribute :country_code do |object|
      country_code_for object
    end

    attribute :phone_number do |object|
      phone_number_for object
    end

    attribute :favourite_products_count do |object|
      object&.favourite_products&.count
    end

    attribute :food_basket_count do |object|
      object&.orders&.count
    end

    attribute :fav_smart_search_count do |object|
      object&.favourite_searches&.count
    end

    attribute :added_member_count do |object|
      object&.add_profiles&.count
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

    class << self
      private

      def country_code_for(object)
        return nil unless Phonelib.valid?(object.full_phone_number)

        Phonelib.parse(object.full_phone_number).country_code
      end

      def phone_number_for(object)
        return nil unless Phonelib.valid?(object.full_phone_number)

        Phonelib.parse(object.full_phone_number).raw_national
      end
    end
  end
end
