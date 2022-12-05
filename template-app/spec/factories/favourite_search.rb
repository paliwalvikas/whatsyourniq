FactoryBot.define do
  factory :favourite_search, class: BxBlockCatalogue::FavouriteSearch do
    product_category {{"Packaged Food" => ["Jams, Honey & Spreads"]}.to_json}
    product_sub_category {{"Packaged Food" => {"Jams, Honey & Spreads" => ['Jams & Spreads']}}.to_json}
    niq_score {['A']}
    food_allergies {['Egg']}
    food_preference {['Vegan']}
    functional_preference {{"Vit A": ['High', 'Low']}.to_json}
    health_preference {"Immunity"}
    favourite {true}
    # product_count {1}
    # added_count {1}
    food_type {['Packaged Food']}
    account_id {FactoryBot.create(:social_account).id}
  end
end