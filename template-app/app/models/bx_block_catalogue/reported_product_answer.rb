# frozen_string_literal: true

module BxBlockCatalogue
  class ReportedProductAnswer < BxBlockCatalogue::ApplicationRecord
    self.table_name = :reported_product_answers
    belongs_to :reported_product_question
  end
end
