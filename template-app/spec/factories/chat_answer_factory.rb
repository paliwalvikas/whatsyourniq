FactoryBot.define do
  factory :chat_answer, class: BxBlockChat::ChatAnswer do
    account_id { "1" } 
    chat_id { "1"}
    answer { "Good" }
  end
end
