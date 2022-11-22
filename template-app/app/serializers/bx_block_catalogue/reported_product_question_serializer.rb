module BxBlockCatalogue
  class ReportedProductQuestionSerializer < BuilderBase::BaseSerializer
    attributes :reported_question

    attribute :reported_question_answer do |object, params|
      ReportedProductAnswerSerializer.new(object.reported_product_answers)
    end

  end
end