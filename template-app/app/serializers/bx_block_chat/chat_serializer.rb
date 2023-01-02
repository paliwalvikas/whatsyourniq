module BxBlockChat
  class ChatSerializer < BuilderBase::BaseSerializer
    attributes :id, :chat_type, :question, :created_at, :updated_at

    attributes :answer_options do |obj|
    	AnswerOptionSerializer.new(obj&.answer_options)
    end
  end
end
