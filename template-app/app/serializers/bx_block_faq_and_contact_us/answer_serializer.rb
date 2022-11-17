module BxBlockFaqAndContactUs
  class AnswerSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer
    attributes *[
      :id,
      :answer,
      :faq_id,
      :created_at,
      :updated_at
    ]
  end
  
end
