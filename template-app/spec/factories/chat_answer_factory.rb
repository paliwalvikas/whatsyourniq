FactoryBot.define do
  factory :chat_answer, class: BxBlockChat::ChatAnswer do
    chat_id { FactoryBot.create(:chat).id }
    account_id { FactoryBot.create(:account).id } 
    answer_option_id { FactoryBot.create(:answer_option).id }
    answer { "Good" }
  end
end
