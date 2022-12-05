require 'rails_helper'

RSpec.describe BxBlockCatalogue::FavouriteSearchesController, type: :controller do
  let (:favourite_search) {FactoryBot.create(:favourite_search)}

  before do
    @account = favourite_search.account
    @token = BuilderJsonWebToken.encode(@account.id)
  end

  describe "Post 'create' social login" do
  	it 'Create Favourite Search' do
      expect do
        post :create, params: { data: {niq_score: ['A']}}
      end.to change { BxBlockCatalogue::FavouriteSearch.count }
    end
  end

  describe 'Update Favourite Search' do
    it 'Update Favourite Search' do
      patch :update, params: {id: favourite_search.id, token: @token, data: {niq_score: ['A'], food_allergies: ['Fish','Egg'], }}
      favourite_search = JSON.parse(response.body)
      expect(favourite_search['data']['attributes']['favourite']).to eq true
    end
  end

  describe "DELETE Favourite Search" do
    it "should respond with Favourite Search" do 
      delete :destroy, params: {id: favourite_search.id, token: @token}
      json = JSON.parse(response.body)
      expect(json["success"]).to eq true
    end
  end

end