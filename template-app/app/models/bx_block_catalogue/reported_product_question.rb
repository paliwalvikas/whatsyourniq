module BxBlockCatalogue
  class ReportedProductQuestion < BxBlockCatalogue::ApplicationRecord
    self.table_name = :reported_product_questions
    validates :reported_question, presence: true, format: { with: /[[:alpha:]]/ }
    has_many :reported_product_answers, class_name: 'BxBlockCatalogue::ReportedProductAnswer'
    accepts_nested_attributes_for :reported_product_answers, :allow_destroy => true
    validate :should_have_reported_product_answers

    private

    def should_have_reported_product_answers
       errors.add(:base, "At least one reported answer option is required.") if reported_product_answers.blank?
    end
  end
end
