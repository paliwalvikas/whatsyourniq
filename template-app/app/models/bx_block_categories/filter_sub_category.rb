# frozen_string_literal: true

module BxBlockCategories
  class FilterSubCategory < BxBlockCategories::ApplicationRecord
    self.table_name = :filter_sub_categories

    belongs_to :filter_category, class_name: 'BxBlockCategories::FilterCategory', foreign_key: 'filter_category_id'

    has_many :products, class_name: 'BxBlockCatalogue::Product', dependent: :destroy
  end
end
