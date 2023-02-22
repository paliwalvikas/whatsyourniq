# frozen_string_literal: true

module BxBlockCategories
  class FilterCategoryRange < BxBlockCategories::ApplicationRecord
    self.table_name = :filter_category_range

    belongs_to :filter_category, foreign_key: 'filter_category_id'

    def filter_category_data
      category = BxBlockCategories::Category.find_by(category_type: 'raw_food')
      filter_category_ids = BxBlockCatalogue::Product.where(category: category.id).pluck(:filter_category_id)
      BxBlockCategories::FilterCategory.where(id: filter_category_ids) 
    end

  end
end
