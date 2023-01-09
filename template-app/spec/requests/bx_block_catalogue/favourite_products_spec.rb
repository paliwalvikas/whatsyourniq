require 'rails_helper'

RSpec.describe "BxBlockCatalogue::FavouriteProduct", type: :request do
	describe  "GET /bx_block_catalogue/favourite_products" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:favourite_product) { create(:favourite_product, product_id: product.id) }

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


    it "Get favourite_products#filter_fav_product" do
    	token = Support::ApiHelper.authenticated_user(favourite_product.account)
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/filter_fav_product", :params =>  {
        token: token,
        product_rating: ['A', 'B']
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:data]).not_to be_nil
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end


    it "When Product not found #fav_search" do
    	token = Support::ApiHelper.authenticated_user(favourite_product.account)
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/fav_search", :params =>  {
        token: token 
      }, :headers => headers
      
      json = JSON.parse(response.body).deep_symbolize_keys
    
      expect(json[:errors]).to eq  'Product Not Found' 
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end

    it "Get /favourite_products#fav_search" do
    	token = Support::ApiHelper.authenticated_user(favourite_product.account)
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/fav_search", :params =>  {
        token: token,
        query: BxBlockCatalogue::Product.last.product_name 
      }, :headers => headers
      json = JSON.parse(response.body).deep_symbolize_keys
     
      expect(json[:data]).not_to be_nil
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
	end
end