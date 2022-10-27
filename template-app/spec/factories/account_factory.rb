FactoryGirl.define do
  factory :account, class: AccountBlock::Account do
    first_name {"Rajesh"}
    last_name {"Jitesh"}
    full_phone_number {915454365345}
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
    gender {1}
    age {22}
    additional_details {"my additional details"}
  end
end
