FactoryBot.define do
  factory :language, class: BxBlockLanguageOptions::Language do
    name { 'English' }
    language_code { 'en' }
    language_type { 'English' }
  end
end