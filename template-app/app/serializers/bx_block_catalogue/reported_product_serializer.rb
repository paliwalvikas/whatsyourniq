module BxBlockCatalogue
  class ReportedProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :status, :description, :ans_ids, :created_at, :updated_at

    attribute :product do |object, params|
      ProductSerializer.new(object.product)
    end

  end
end