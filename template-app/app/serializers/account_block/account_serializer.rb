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
