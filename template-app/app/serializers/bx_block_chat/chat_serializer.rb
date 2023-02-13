module BxBlockChat
  class ChatSerializer < BuilderBase::BaseSerializer
    attributes :id, :chat_type, :question, :radio, :created_at, :updated_at

    attributes :answer_options do |obj|
      AnswerOptionSerializer.new(obj&.answer_options)
    end

    attributes :chat_answers do |obj, _params|
      obj = obj&.chat_answers&.find_by(account_id: _params[:account]&.id)
      if obj.present?
        ans =	if obj.answer.present?
                obj.answer
              elsif obj.answer_option_id&.present?
                obj&.answer_option&.option
              elsif obj.image.attached?
                if Rails.env.development?
                  Rails.application.routes.url_helpers.rails_blob_path(obj.image, only_path: true)
                else
                  obj.image&.service_url&.split('?')&.first
                end
              end
      end
      { id: obj&.id, answer: ans }
    end
  end
end
