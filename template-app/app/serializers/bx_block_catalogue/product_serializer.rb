module BxBlockCatalogue
  class ProductSerializer < BuilderBase::BaseSerializer
    attributes :id, :product_name, :product_type, :product_point, :product_rating, :positive_good, :negative_not_good, :created_at, :updated_at
    
    attribute :category_type do |object|
      BxBlockCategories::Category.find_by(id: object.category_id)
    end
  end
end
