FactoryBot.define do
  factory :about_content, class: BxBlockContentManagement::AboutContent do
    title {"my title"}
    description {"my description"}
  end
end
