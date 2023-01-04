FactoryBot.define do
  factory :favourite_product, class: BxBlockCatalogue::FavouriteProduct do
    account_id { FactoryBot.create(:social_account).id }
    product_id { FactoryBot.create(:product, category_id: 1, filter_category_id: 1, filter_sub_category_id: 1).id }
    favourite { true }
  end
end