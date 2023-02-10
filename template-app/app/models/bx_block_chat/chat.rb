module BxBlockChat
  class Chat < ApplicationRecord
    self.table_name = :chats

    validates :chat_type, presence: true, allow_blank: false
    validates :question, presence: true, allow_blank: false, format: { with: /[[:alpha:]]/ }

   	has_many :chat_answers, class_name: "BxBlockChat::ChatAnswer", dependent: :destroy
    has_many :answer_options, class_name: 'BxBlockChat::AnswerOption', dependent: :destroy
 	
    accepts_nested_attributes_for :answer_options, :allow_destroy => true
  end  
end

