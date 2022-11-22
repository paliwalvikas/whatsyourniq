module BxBlockCatalogue
  class ReportedProductQuestion < BxBlockCatalogue::ApplicationRecord
    self.table_name = :reported_product_questions
    validates :reported_question, presence: true, allow_blank: false
    has_many :reported_product_answers, class_name: 'BxBlockCatalogue::ReportedProductAnswer'
    accepts_nested_attributes_for :reported_product_answers, :allow_destroy => true
  end
end
