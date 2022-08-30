module BxBlockCategories
  class CategorySerializer < BuilderBase::BaseSerializer

    attributes  :category_type do |obj|
      obj.category_type&.titleize
    end
  end
end
