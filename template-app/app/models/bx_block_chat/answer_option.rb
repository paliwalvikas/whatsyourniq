module BxBlockChat
  class AnswerOption < ApplicationRecord
    self.table_name = :answer_options

    validates :option, presence: true, allow_blank: false
    belongs_to :chat, class_name: 'BxBlockChat::Chat'
    belongs_to :chat_option_category, class_name: 'BxBlockCategories::ChatOptionCategory', optional: true
    has_many :chat_answers, class_name: 'BxBlockChat::ChatAnswer', dependent: :destroy
  end
end
