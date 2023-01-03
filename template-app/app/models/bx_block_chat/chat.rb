module BxBlockChat
  class Chat < ApplicationRecord
    self.table_name = :chats

    validates :chat_type, :question, presence: true, allow_blank: false

   	has_one :chat_answer, class_name: "BxBlockChat::ChatAnswer", dependent: :destroy
    has_many :answer_options, class_name: 'BxBlockChat::AnswerOption', dependent: :destroy
 	
    accepts_nested_attributes_for :answer_options, :allow_destroy => true

  end  
end

