# frozen_string_literal: true

module BxBlockCategories
  class Category < BxBlockCategories::ApplicationRecord
    self.table_name = :categories
    has_and_belongs_to_many :sub_categories,
    join_table: :categories_sub_categories, dependent: :destroy
    has_many :products, class_name: 'BxBlockCatalogue::Product', dependent: :destroy
    has_many :requested_products, class_name: 'BxBlockCatalogue::RequestedProduct', foreign_key: 'category_id'

    scope :category_type, ->(category_type) { where category_type: category_type }

    enum category_type: %i[packaged_food raw_food cooked_food]

    def find_category_type(val)
      category_type = case val
                      when 'Packaged Foods'
                        'packaged_food'
                      when 'Raw Foods'
                        'raw_food'
                      else
                        'cooked_food'
                      end
      BxBlockCategories::Category.find_or_create_by(category_type: category_type)&.id || BxBlockCategories::Category.first&.id
    end
  end
end
