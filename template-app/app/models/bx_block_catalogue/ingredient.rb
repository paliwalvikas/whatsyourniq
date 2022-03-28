module BxBlockCatalogue
  class Ingredient < BxBlockCatalogue::ApplicationRecord
    self.table_name = :ingredients
    belongs_to :product, class_name: "BxBlockCatalogue::Product" 
    validates :product_id, uniqueness: true
  end
end
