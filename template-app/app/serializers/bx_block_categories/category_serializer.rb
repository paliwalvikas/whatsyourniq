module BxBlockCategories
  class CategorySerializer < BuilderBase::BaseSerializer

    attributes :category_type do |obj|
      I18n.t("models.bx_block_categories.category.category_type.#{obj.category_type}")
    end
  end
end
