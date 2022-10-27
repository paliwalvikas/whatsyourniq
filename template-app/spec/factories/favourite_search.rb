FactoryGirl.define do
  factory :favourite_search, class: BxBlockCatalogue::FavouriteSearch do
    product_category {{"Packaged Food" => ["Jams, Honey & Spreads"]}}
    product_sub_category {{"Packaged Food" => {"Jams, Honey & Spreads" => ['Jams & Spreads']}}}
    niq_score {"4234"}
    food_allergies {"No"}
    food_preference {""}
    functional_preference {"good"}
    health_preference {"good"}
    favourite {true}
    product_count {1}
    added_count {1}
    food_type {['Packaged Food']}
  end
end
