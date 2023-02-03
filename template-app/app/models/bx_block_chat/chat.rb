module BxBlockChat
  class Chat < ApplicationRecord
    self.table_name = :chats

    validates :chat_type, presence: true, allow_blank: false
    validates :question, presence: true, allow_blank: false, format: { with: /[[:alpha:]]/ }

   	has_one :chat_answer, class_name: "BxBlockChat::ChatAnswer", dependent: :destroy
    has_many :answer_options, class_name: 'BxBlockChat::AnswerOption', dependent: :destroy
 	
    accepts_nested_attributes_for :answer_options, :allow_destroy => true
    validate :should_have_answer_option

    private

    def should_have_answer_option
       errors.add(:base, "At least one answer option is required.") if answer_options.blank?
    end
  end  
end

