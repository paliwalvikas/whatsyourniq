# frozen_string_literal: true

module BxBlockCategories
  class FilterCategory < BxBlockCategories::ApplicationRecord
    self.table_name = :filter_categories

    has_one :filter_sub_categories, class_name: 'BxBlockCategories::FilterSubCategory', dependent: :destroy

    has_many :products, class_name: 'BxBlockCatalogue::Product', dependent: :destroy
    has_one :filter_category_range, foreign_key: 'filter_category_id' , dependent: :destroy
  end
end
