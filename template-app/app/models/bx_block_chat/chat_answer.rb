module BxBlockChat
  class ChatAnswer < ApplicationRecord
    self.table_name = :chat_answers

    belongs_to :answer_option, 
                class_name: 'BxBlockChat::AnswerOption',
                foreign_key: :answer_option_id, optional: true
    belongs_to :account, 
              class_name: 'AccountBlock::Account'
    belongs_to :chat, 
              class_name: "BxBlockChat::Chat"
    has_one_attached :image

  end  
end

