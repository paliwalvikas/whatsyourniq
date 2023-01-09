FactoryBot.define do
  factory :add_profile, class: BxBlockAddProfile::AddProfile do
    full_name { Faker::Internet.user_name } 
    age { 76 }
    gender { 'female' }
    email { Faker::Internet.email }
    height { 12.3 }
    weight { 67.9 }
    address { Faker::Address.full_address }
    pincode { Faker::Address.zip_code }
    city { Faker::Address.city}
    state { Faker::Address.state }
    activity_level {'medium'}
    contact_no { Faker::Base.numerify('91#######')+SecureRandom.random_number(100..999).to_s }
    relation_id {FactoryBot.create(:relation).id}
    # image {Faker::LoremFlickr.unique.image}
    account_id { FactoryBot.create(:social_account).id }
  end
end
