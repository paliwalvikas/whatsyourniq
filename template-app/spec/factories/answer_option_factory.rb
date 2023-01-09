FactoryBot.define do
  factory :answer_option, class: BxBlockChat::AnswerOption do
    option { 'Good' }
    chat_id { FactoryBot.create(:chat).id }
  end
end
