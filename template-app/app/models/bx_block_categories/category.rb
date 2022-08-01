# frozen_string_literal: true

module BxBlockCategories
  class Category < BxBlockCategories::ApplicationRecord
    self.table_name = :categories

    # mount_uploader :light_icon, ImageUploader
    # mount_uploader :light_icon_active, ImageUploader
    # mount_uploader :light_icon_inactive, ImageUploader
    # mount_uploader :dark_icon, ImageUploader
    # mount_uploader :dark_icon_active, ImageUploader
    # mount_uploader :dark_icon_inactive, ImageUploader

    # has_and_belongs_to_many :sub_categories,
    # join_table: :categories_sub_categories, dependent: :destroy

    # has_many :contents, class_name: "BxBlockContentmanagement::Content", dependent: :destroy
    # has_many :ctas, class_name: "BxBlockCategories::Cta", dependent: :nullify

    # has_many :user_categories, class_name: "BxBlockCategories::UserCategory",
    #          join_table: "user_categoeries", dependent: :destroy
    # has_many :accounts, class_name: "AccountBlock::Account", through: :user_categories,
    #          join_table: "user_categoeries"
    has_many :favourite_searches, class_name: 'BxBlockCatalogue::FavouriteSearch', dependent: :destroy
    has_many :products, class_name: 'BxBlockCatalogue::Product', dependent: :destroy
    # enum category_type: [:Packaged_Food, :raw_food, :cooked_food]

    scope :category_type, ->(category_type) { where category_type: category_type }

    enum category_type: %i[packaged_food raw_food cooked_food]

    def find_category_type(val)
      category_type = case val
                      when 'Packaged Foods'
                        'packaged_food'
                      when 'Row Foods'
                        'raw_food'
                      else
                        'cooked_food'
                      end
      Category.find_by(category_type: category_type).id
    end
  end
end
