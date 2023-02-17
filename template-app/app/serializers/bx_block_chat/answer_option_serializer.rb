module BxBlockChat
  class AnswerOptionSerializer < BuilderBase::BaseSerializer
    attributes :id, :option, :chat_id, :message, :marks, :created_at, :updated_at
  end
end
