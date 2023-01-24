FactoryBot.define do
  factory :social_account, class: AccountBlock::SocialAccount do
    # type{'social_account'}
    first_name {"Rajesh"}
    last_name {"Jitesh"}
    full_phone_number {917693063000}
    country_code {91}
    phone_number {5454365345}
    email { Faker::Internet.email}
    activated {true}
    device_id {"fsdfewst4w3543gdftert"}
    unique_auth_id {"fsdfsdwer453tewr4w35"}
    user_name {"rjb"}
    platform {"Web"}
    user_type {"Adult"}
    app_language_id {7663}
    last_visit_at {"11 June 2022"}
    is_blacklisted {false}
    suspend_until {"23 June 2022"}
    status {1}
    stripe_id {"79823hfiwdiewhhfd"}
    stripe_subscription_id {"jfsdjflsdksjdfl4324234"}
    stripe_subscription_date {"22 June 2022"}
    full_name {"R J Bihari"}
    flag {true}
    gender {"male"}
    age {22}
    additional_details {"my additional details"}
  end

  factory :sms_account, class: AccountBlock::SmsAccount do
    # type{'social_account'}
    first_name {"Rajesh"}
    last_name {"Jitesh"}
    full_phone_number {917693063090}
    country_code {91}
    phone_number {5454365345}
    email {"my_test123@gmail.com"}
    activated {true}
    device_id {["fsdfewst4w3543gdftert"]}
    unique_auth_id {"fsdfsdwer453tewr4w35"}
    user_name {"rjb"}
    platform {"Web"}
    user_type {"Adult"}
    app_language_id {7663}
    last_visit_at {"11 June 2022"}
    is_blacklisted {false}
    suspend_until {"23 June 2022"}
    status {1}
    stripe_id {"79823hfiwdiewhhfd"}
    stripe_subscription_id {"jfsdjflsdksjdfl4324234"}
    stripe_subscription_date {"22 June 2022"}
    full_name {"R J Bihari"}
    flag {true}
    gender {"male"}
    age {22}
    additional_details {"my additional details"}
  end

  factory :account, class: AccountBlock::Account do
    # type{'social_account'}
    first_name {"Rajesh"}
    last_name {"Jitesh"}
    full_phone_number {917693063090}
    country_code {91}
    phone_number {5454365345}
    email {"my_test123@gmail.com"}
    activated {true}
    device_id {["fsdfewst4w3543gdftert"]}
    unique_auth_id {"fsdfsdwer453tewr4w35"}
    user_name {"rjb"}
    platform {"Web"}
    user_type {"Adult"}
    app_language_id {7663}
    last_visit_at {"11 June 2022"}
    is_blacklisted {false}
    suspend_until {"23 June 2022"}
    status {1}
    stripe_id {"79823hfiwdiewhhfd"}
    stripe_subscription_id {"jfsdjflsdksjdfl4324234"}
    stripe_subscription_date {"22 June 2022"}
    full_name {"R J Bihari"}
    flag {true}
    gender {"male"}
    age {22}
    additional_details {"my additional details"}
  end
end
