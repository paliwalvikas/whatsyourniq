# frozen_string_literal: true

module BxBlockCatalogue
  class Product < BxBlockCatalogue::ApplicationRecord
    self.table_name = :products

    validates :bar_code, uniqueness: true
    validates :bar_code, presence: true

    attr_accessor :image_url, :category_filter, :category_type_filter

    has_one_attached :image
    has_one :health_preference, class_name: 'BxBlockCatalogue::HealthPreference', dependent: :destroy
    has_one :ingredient, class_name: 'BxBlockCatalogue::Ingredient', dependent: :destroy
    has_many :order_items, class_name: 'BxBlockCatalogue::OrderItem', dependent: :destroy
    belongs_to :category, class_name: 'BxBlockCategories::Category', foreign_key: 'category_id'
    belongs_to :filter_category, class_name: 'BxBlockCategories::FilterCategory', foreign_key: 'filter_category_id'
    belongs_to :filter_sub_category, class_name: 'BxBlockCategories::FilterSubCategory',
                                     foreign_key: 'filter_sub_category_id'
    has_many :favourite_products, class_name: 'BxBlockCatalogue::FavouriteProduct', dependent: :destroy
    has_many :compare_products, class_name: 'BxBlockCatalogue::CompareProduct', dependent: :destroy
    has_many :reported_products, class_name: 'BxBlockCatalogue::ReportedProduct', foreign_key: 'product_id',
                                 dependent: :destroy
    has_many :loged_foods, class_name: 'BxBlockCatalogue::LogedFood',foreign_key: 'account_id', dependent: :destroy
    belongs_to :account, class_name: 'AccountBlock::Account', foreign_key: 'account_id', optional: true                             
    enum product_type: %i[cheese_and_oil beverage solid]
    enum food_drink_filter: %i[food drink]

    accepts_nested_attributes_for :ingredient, allow_destroy: true

    after_create :product_health_preference
    after_save :save_image_url_in_db
    scope :green, -> { where(data_check: 'green') }
    scope :red, -> { where(data_check: 'red') }
    scope :n_a, -> { where(data_check: 'na') }
    scope :n_c, -> { where(data_check: 'nc') }
    scope :product_type, ->(product_type) { where product_type: product_type }
    scope :product_rating, ->(product_rating) { where product_rating: product_rating }
    scope :food_drink_filter, ->(food_drink_filter) { where food_drink_filter: food_drink_filter }
    scope :filter_category_id, ->(filter_category_id) { where filter_category_id: filter_category_id }
    scope :filter_sub_category_id, ->(filter_sub_category_id) { where filter_sub_category_id: filter_sub_category_id }

    def product_health_preference
      health = { "Immunity": nil, "Gut Health": nil, "Holistic Nutrition": nil, "Weight loss": nil, "Weight gain": nil,
                 "Diabetic": nil, "Low Cholesterol": nil, "Heart Friendly": nil, "Energy and Vitality": nil, "Physical growth": nil, "Cognitive health": nil, "High Protein": nil, "Low Sugar": nil }
      hsh = {}
      health.each do |key, value|
        value = BxBlockCatalogue::ProductHealthPreferenceService.new.health_preference(self, key.to_s)
        key = key.to_s.include?(' ') ? key.to_s.downcase.tr!(' ', '_') : key.to_s.downcase
        hsh[key.to_sym] = value
      end
      if health_preference.present?
        health_preference.update(hsh)
      else
        create_health_preference(hsh)
      end
    end

    def product_type=(val)
      self[:product_type] = val&.downcase
    end

    def food_drink_filter=(val)
      self[:food_drink_filter] = val&.downcase
    end

    def data_check=(val)
      self[:data_check] = val&.downcase || 'NA'
    end

    def image_process
      begin
        file = open(image_url)
      rescue Errno::ENOENT, OpenURI::HTTPError, Errno::ENAMETOOLONG, Net::OpenTimeout, URI::InvalidURIError
        file = open('lib/image_not_found.jpeg')
      end
      image.attach(io: file, filename: 'some-image.jpg', content_type: 'image/jpg')
    end

    def compare_product_good_not_so_good_ingredients
      BxBlockCatalogue::ProductService.new(ingredient, product_type).calculation_for_rdas
    end

    # saving image url in db to reduce the time taking of api
    def save_image_url_in_db
      self.image_url = image.service_url if image.present?
    end

    def reported_product
      ids = BxBlockCatalogue::ReportedProduct.pluck(:account_id)
      AccountBlock::Account.where(id: ids).pluck(:full_name, :id)
    end
  end
end
