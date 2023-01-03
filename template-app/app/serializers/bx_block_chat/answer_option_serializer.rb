module BxBlockChat
  class AnswerOptionSerializer < BuilderBase::BaseSerializer
    attributes :id, :option, :chat_id, :created_at, :updated_at
  end
end
