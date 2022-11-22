module BxBlockCatalogue
  class ReportedProductAnswer < BxBlockCatalogue::ApplicationRecord
    self.table_name = :reported_product_answers
    belongs_to :reported_product_question, class_name: 'BxBlockCatalogue::ReportedProductQuestion'
  end
end
