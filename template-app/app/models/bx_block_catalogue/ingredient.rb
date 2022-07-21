module BxBlockCatalogue
  class Ingredient < BxBlockCatalogue::ApplicationRecord
    self.table_name = :ingredients
    belongs_to :product, class_name: "BxBlockCatalogue::Product" 
    validates :product_id, uniqueness: true

    scope :veg_and_nonveg, ->(veg_and_nonveg) { where veg_and_nonveg: veg_and_nonveg }
    scope :gluteen_free, ->(gluteen_free) { where gluteen_free: gluteen_free }
    scope :added_sugar, ->(added_sugar) { where added_sugar: added_sugar }
    scope :artificial_preservative, ->(artificial_preservative) { where artificial_preservative: artificial_preservative }
    scope :organic, ->(organic) { where organic: organic }
    scope :vegan_product, ->(vegan_product) { where vegan_product: vegan_product }

  end
end
