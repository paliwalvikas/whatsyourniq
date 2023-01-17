# frozen_string_literal: true

module BxBlockCatalogue
  class ReportedProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :status, :description, :ans_ids, :comment, :created_at, :updated_at

    attribute :product do |object, _params|
      ProductSerializer.new(object.product)
    end

    attribute :reported_product_answer do |object|
    	answers = ReportedProductAnswer.where(id: object&.ans_ids)
    	ReportedProductAnswerSerializer.new(answers)
    end
  end
end
