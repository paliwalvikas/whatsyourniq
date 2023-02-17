module BxBlockChat
  class ChatAnswerSerializer < BuilderBase::BaseSerializer
    attributes :id, :chat_id, :account_id #, :created_at, :updated_at

    attribute :answer do |obj|
      if obj.answer.present?
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
  end
end
