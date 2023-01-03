module BxBlockChat
  class AnswerOption < ApplicationRecord
    self.table_name = :answer_options

    validates :option, presence: true, allow_blank: false
    belongs_to :chat, class_name: "BxBlockChat::Chat"

   	has_one :chat_answer, class_name: "BxBlockChat::ChatAnswer", dependent: :destroy
  end  
end

