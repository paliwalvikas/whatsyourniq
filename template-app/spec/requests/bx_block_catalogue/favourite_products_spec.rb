require 'rails_helper'

RSpec.describe "BxBlockCatalogue::FavouriteProduct", type: :request do
	describe  "GET /bx_block_catalogue/favourite_products" do
    let(:favourite_product) { create(:favourite_product) }

    it "should not respond with BxBlockCatalogue::FavouriteProduct when with token" do           
     
      token = Support::ApiHelper.authenticated_user(favourite_product.account)
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/favourite_products", :params => {
        favourite_product: favourite_product,
        token: token
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:data]).not_to be_nil
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end

    it "should not respond with BxBlockCatalogue::FavouriteProduct when without token" do

      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/favourite_products", :params =>  {
        favourite_product: favourite_product
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq [{:token=>"Invalid token"}]
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:bad_request)
    end
	end
end