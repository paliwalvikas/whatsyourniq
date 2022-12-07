FactoryBot.define do
  factory :favourite_product, class: BxBlockCatalogue::FavouriteProduct do
    account_id { FactoryBot.create(:social_account).id }
    product_id { BxBlockCatalogue::Product.last.id}
    favourite { true }
  end
end