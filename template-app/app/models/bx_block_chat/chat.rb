module BxBlockChat
  class Chat < ApplicationRecord
    self.table_name = :chats

    validates :chat_type, presence: true, allow_blank: false
    validates :question, presence: true, allow_blank: false, format: { with: /[[:alpha:]]/ }
    enum answer_type: {text: 0 ,number: 1, radio_button: 2, check_box: 3, date_picker: 4, bmi_scale: 5, image_picker: 6}

    scope :chat_type, ->(chat_type) { where chat_type: chat_type }

   	has_many :chat_answers, class_name: "BxBlockChat::ChatAnswer", dependent: :destroy
    has_many :answer_options, class_name: 'BxBlockChat::AnswerOption', dependent: :destroy
 	
    accepts_nested_attributes_for :answer_options, :allow_destroy => true
  end  
end

