FactoryBot.define do
  factory :chat, class: BxBlockChat::Chat do
    chat_type { 'Personal' }
    question { 'What is your name?' }
  end
end
