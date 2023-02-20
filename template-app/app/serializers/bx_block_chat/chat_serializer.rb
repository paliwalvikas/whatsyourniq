module BxBlockChat
  class ChatSerializer < BuilderBase::BaseSerializer
    attributes :id, :chat_type, :question, :answer_type, :created_at, :updated_at

    attributes :answer do |obj, _params|
      _params[:account].chat_answers&.present? ? "1" : "0" 
    end

    attributes :answer_options do |obj|
      AnswerOptionSerializer.new(obj&.answer_options)
    end

    attributes :chat_answers do |object, _params|
      obj = object&.chat_answers&.where(chat_id: object.id, account_id: _params[:account]&.id)
      ChatAnswerSerializer.new(obj, params: _params[:host])
    end
  end
end
