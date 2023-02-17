module BxBlockChat
  class ChatAnswerSerializer < BuilderBase::BaseSerializer
    attributes :id, :chat_id, :account_id #, :created_at, :updated_at

    attribute :answer do |obj, params|
      if obj.answer.present?
        obj.answer
      elsif obj.answer_option_id&.present?
        obj&.answer_option&.option
      elsif obj.image.attached?
        host = params[:host] || ""

        if obj.image.attached?
              host + Rails.application.routes.url_helpers.rails_blob_url(
                obj.image, only_path: true
              )
        end
      end
    end
  end
end
