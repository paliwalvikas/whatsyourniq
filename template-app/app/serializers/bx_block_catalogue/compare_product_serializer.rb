module BxBlockCatalogue
  class CompareProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :selected, :account_id, :product_id, :created_at, :updated_at
  end
end
