module BxBlockChat
  class ChatSerializer < BuilderBase::BaseSerializer
    attributes :id, :chat_type, :question, :created_at, :updated_at

    attributes :answer_options do |obj|
    	AnswerOptionSerializer.new(obj&.answer_options)
    end

    attributes :chat_answers do |obj, _params|
    	ChatAnswerSerializer.new(obj&.chat_answers&.where(account_id: _params[:account]&.id), params: _params[:host])
    end
  end
end
