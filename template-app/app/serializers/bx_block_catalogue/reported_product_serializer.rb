# frozen_string_literal: true

module BxBlockCatalogue
  class ReportedProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :status, :description, :ans_ids, :comment, :created_at, :updated_at

    attribute :product do |object, _params|
      ProductSerializer.new(object.product)
    end
  end
end
