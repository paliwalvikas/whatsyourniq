FactoryBot.define do
  factory :add_profile, class: BxBlockAddProfile::AddProfile do
    full_name {"A. B Marathe"}
    weight {58}
    height {1.70}
    age {"23"}
    email {"the123@gmail.com"}
    contact_no {917498154399}
    address {"Lakshiminagar"}
    pincode {"424101"}
    activity_level {"medium"}
    state {"MP"}
    city {"Indore"}
    gender {"male"}
  end
end
