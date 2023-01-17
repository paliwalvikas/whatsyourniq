module BxBlockCatalogue
  class ReportedProductAnswerSerializer < BuilderBase::BaseSerializer
    attributes :id, :reported_answer

    attributes :reported_product_question do |object|
    	object&.reported_product_question
    end
  end
end