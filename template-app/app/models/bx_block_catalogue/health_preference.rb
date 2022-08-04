module BxBlockCatalogue
  class HealthPreference < BxBlockCatalogue::ApplicationRecord
    self.table_name = :health_preferences

    belongs_to :product, class_name: "BxBlockCatalogue::Product" 
  end
end
