# frozen_string_literal: true

module BxBlockCatalogue
  class LogedFoodSerializer < BuilderBase::BaseSerializer
    attributes :id, :food_type, :quantity, :default_time

    attribute :product do |object, _params|
      ProductSerializer.new(object.product)
    end

    attribute :account do |object, _params|
      AccountBlock::AccountSerializer.new(object.account)
    end
  end
end
