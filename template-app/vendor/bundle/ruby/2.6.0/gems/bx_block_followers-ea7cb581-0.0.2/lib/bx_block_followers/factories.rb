FactoryBot.define do
    factory :follow, :class => 'BxBlockFollowers::Follow' do
      account_id { 1 }
      current_user_id { 1 }
    end
end