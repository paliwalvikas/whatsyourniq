module BxBlockFaqAndContactUs
  class FaqSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer
    attributes *[
      :id,
      :question,
      :created_at,
      :updated_at
    ]

    attributes :answer do |object|
      AnswerSerializer.new(object&.answers)
    end
  end

end
