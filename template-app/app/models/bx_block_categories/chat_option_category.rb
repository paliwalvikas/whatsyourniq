module BxBlockCategories
  class ChatOptionCategory < ApplicationRecord
    self.table_name = :chat_option_categories

    has_many :answer_options, class_name: 'BxBlockChat::AnswerOption', dependent: :destroy
  end
end
