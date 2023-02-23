# frozen_string_literal: true

module BxBlockChat
  class ChatAnswer < ApplicationRecord
    self.table_name = :chat_answers

    belongs_to :add_profile,
               class_name: 'BxBlockAddProfile::AddProfile',
               optional: true
    belongs_to :answer_option,
               class_name: 'BxBlockChat::AnswerOption',
               foreign_key: :answer_option_id, optional: true
    belongs_to :account,
               class_name: 'AccountBlock::Account'
    belongs_to :chat,
               class_name: 'BxBlockChat::Chat'
    has_one_attached :image, dependent: :destroy

    after_save :updating_details, if: :check_val?
    after_create :bmi_score

    private

    def check_val?
      chat&.question&.downcase&.include?('height') || chat&.question&.downcase&.include?('weight') || chat&.question&.downcase&.include?('date of birth')
    end

    def updating_details
      if account.present? && add_profile.nil? && chat&.question&.downcase&.include?('height')
        account.update(height: answer.to_f)
      elsif account.present? && add_profile.nil? && chat&.question&.downcase&.include?('weight')
        account.update(weight: answer.to_f)
      elsif account.present? && add_profile.nil? && chat&.question&.downcase&.include?('date of birth')
        account.update(age: answer.to_i)
      elsif add_profile.present? && chat&.question&.downcase&.include?('height')
        add_profile.update(height: answer.to_f)
      elsif add_profile.present? && chat&.question&.downcase&.include?('weight')
        add_profile.update(weight: answer.to_f)
      elsif add_profile.present? && chat&.question&.downcase&.include?('date of birth')
        add_profile.update(age: answer.to_i)
      end
    end

    def bmi_score
      if chat.question&.downcase&.include?('weight')
        data = 'bmi score'
        c_id = BxBlockChat::Chat.find_by('question ilike ?', "%#{data}%").id
        ChatAnswer.find_or_create_by(chat_id: c_id, answer: 'BMI score', account_id: account.id,
                                     add_profile_id: add_profile&.id)
      end
    end
  end
end
