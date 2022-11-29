require 'rails_helper'

RSpec.describe BxBlockCatalogue::FavouriteSearchesController, type: :controller do
  let (:favourite_search) {FactoryBot.create(:favourite_search)}
  describe "Post 'create' social login" do
  	it 'Create Favourite Searche' do
      expect do
        post :create, params: { data: {niq_score: ['A']}}
      end.to change { BxBlockCatalogue::FavouriteSearch.count }
    end
  end

end