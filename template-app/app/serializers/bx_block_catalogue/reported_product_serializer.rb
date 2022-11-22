module BxBlockCatalogue
  class ReportedProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :status, :description, :ans_ids

    attribute :product do |object, params|
      ProductSerializer.new(object.product)
    end

  end
end