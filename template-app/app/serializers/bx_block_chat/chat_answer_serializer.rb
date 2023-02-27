module BxBlockChat
  class ChatAnswerSerializer < BuilderBase::BaseSerializer
    attributes :id, :chat_id, :account_id, :answer_option_id # , :created_at, :updated_at

    attribute :answer do |obj, _params|
      if obj.answer.present?
        obj.answer
      elsif obj.answer_option_id&.present?
        obj&.answer_option&.option
      end
    end

    attribute :image do |obj, params|
      host = params[:host] || ''

      if obj.image.attached?
        { image: host + Rails.application.routes.url_helpers.rails_blob_url(
          obj.image, only_path: true
        ),
          question: 'Thank you for uploading your pic !',
          answer: 'uploaded' }
      end
    end

    attribute :bmi_calculation do |obj|
      if obj.answer.present? && obj.answer.include?('BMI score')
        { account: obj&.account,
          bmi_result: "you are #{obj.account.bmi_status}" }
      end
    end
  end
end
