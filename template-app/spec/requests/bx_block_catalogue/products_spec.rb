require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /index" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }

    it "should respond with Product#index" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products", :params => {
        id: product.id, ingredient: ingredient
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:data][:id]).not_to be_nil
      expect(json[:data][:attributes]).not_to be_nil
      expect(json[:data][:type]).to eq("product_compare")

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end

    it "when Product not found" do
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products", :params => {
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq("Product not found")

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /update" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }

    it "should respond with Product#update" do                          
      headers = { "ACCEPT" => "application/json" }
      put "/bx_block_catalogue/products/#{product.id}", :params => {
        id: product.id, ingredient: ingredient
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:message]).to eq("Calculated successfully!")
      expect(product.product_type).to eq("beverage")

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end

    it "when Product not found" do
      headers = { "ACCEPT" => "application/json" }
      put "/bx_block_catalogue/products/:id", :params => {
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:error]).to eq("Something went wrong!")

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }

    it "should respond with Product#show" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/#{product.id}", :params => {
        id: product.id, ingredient: ingredient
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:data][:id]).not_to be_nil
      expect(json[:data][:attributes]).not_to be_nil
      expect(json[:data][:type]).to eq("product")

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end

    it "when Product not present" do
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/:id", :params => {
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq("Product not present")

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /niq_score" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }

    it "should respond with Product#niq_score" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/niq_score", :params => {
        product_id: product.id, ingredient: ingredient
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:data]).to eq []
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end

    it "when Product not present" do
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/niq_score", :params => {
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq("Product not found")

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /prod_health_preference" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }
    let(:account) { create(:account)}

    it "should respond with Product#prod_health_preference" do                             
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      post "/bx_block_catalogue/products/prod_health_preference", :params => {
        product: product, ingredient: ingredient
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq [{:token=>"Invalid token"}]
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "POST /change_for_cal" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }
    let(:account) { create(:account) }
    
    it "should respond with Product#change_for_cal" do
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      post "/bx_block_catalogue/products/change_for_cal", :params => {
        product: product, ingredient: ingredient
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq [{:token=>"Invalid token"}]
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "DELETE /delete_health_preference" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }
    let(:account) { create(:account)}
    
    it "should respond with Product#delete_health_preference" do
      token = Support::ApiHelper.authenticated_user(account)
      
      headers = { "ACCEPT" => "application/json" }
      delete "/bx_block_catalogue/products/delete_health_preference", :params => {
        product: product, ingredient: ingredient
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq [{:token=>"Invalid token"}]
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "GET /search" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }
    let(:user) { create(:account)}

    it "should respond with Product#search" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/search", :params => {
        product: product, ingredient: ingredient, query: "THE HONEY SHOP", page: 1, per_page: 8, user: user
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:products][:data]).not_to be_nil
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end

    it "when Product not found" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/search", :params => {
        product: product, ingredient: ingredient, query: "THE HONEY SHOP", page: 2, per_page: 8, user: user
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq "Product Not Found"
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /delete_old_data" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }
    let(:account) { create(:account)}

    it "should respond with Product#delete_old_data" do                             
      headers = { "ACCEPT" => "application/json" }
      delete "/bx_block_catalogue/products/delete_old_data", :params => {
        product: product, ingredient: ingredient
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:message]).to eq "deleted successfully!"
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /smart_search_filters" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }
    let(:user) { create(:account)}

    it "should respond with Product#smart_search_filters" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/smart_search_filters", :params => {
        product: product, ingredient: ingredient, query: "category"
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:category]).to eq [{:count=>0, :category=>"Packaged Cheese And Oil", :category_filter=>[]}]
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /product_smart_search" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }
    let(:account) { create(:account)}
    let(:user) { create(:account)}
    let(:favourite_search) { create(:favourite_search, account_id: account.id) }

    it "should respond with Product#product_smart_search" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/product_smart_search", :params => {
        product: product, ingredient: ingredient, user: user, fav_search_id: favourite_search.id, page: 1, per: 10
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:products]).not_to be_nil
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end

    it "when Product not found" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/product_smart_search", :params => {
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq "Product not found"
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /compare_product" do
    let!(:category) { create(:category) }
    let!(:filter_category) { create(:filter_category) }
    let!(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let!(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let!(:ingredient) { create(:ingredient, product_id: product.id) }
    let!(:health_preference) { create(:health_preference, product_id: product.id) }
    let!(:account) { create(:account)}
    let!(:favourite_search) { create(:favourite_search, account_id: account.id) }
    let!(:compare_product) { create(:compare_product, account_id: account.id, product_id: product.id) }

    it "should respond with Product#compare_product when token present" do
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/compare_product", :params => {
        product: product, ingredient: ingredient, token: token
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:data]).not_to be_nil
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /compare_product" do
    let!(:category) { create(:category) }
    let!(:filter_category) { create(:filter_category) }
    let!(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let!(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let!(:ingredient) { create(:ingredient, product_id: product.id) }
    let!(:health_preference) { create(:health_preference, product_id: product.id) }
    let!(:account) { create(:account)}
    let!(:favourite_search) { create(:favourite_search, account_id: account.id) }

    it "should respond with Product#compare_product when token present" do
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/compare_product", :params => {
        token: token
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:message]).to eq "Please add one more product"
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /compare_product" do
    let!(:category) { create(:category) }
    let!(:filter_category) { create(:filter_category) }
    let!(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let!(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let!(:ingredient) { create(:ingredient, product_id: product.id) }
    let!(:health_preference) { create(:health_preference, product_id: product.id) }
    let!(:account) { create(:account)}
    let!(:favourite_search) { create(:favourite_search, account_id: account.id) }
    let!(:compare_product) { create(:compare_product, account_id: account.id, product_id: product.id) }

    it "should respond with Product#compare_product when token present" do
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/compare_product", :params => {
        product: product, ingredient: ingredient, token: token
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:data]).not_to be_nil
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /compare_product" do
    let!(:category) { create(:category) }
    let!(:filter_category) { create(:filter_category) }
    let!(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let!(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let!(:ingredient) { create(:ingredient, product_id: product.id) }
    let!(:health_preference) { create(:health_preference, product_id: product.id) }
    let!(:account) { create(:account)}
    let!(:favourite_search) { create(:favourite_search, account_id: account.id) }

    it "should respond with Product#compare_product when token present" do
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/compare_product", :params => {
        token: token
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:message]).to eq "Please add one more product"
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /compare_product" do
    let!(:category) { create(:category) }
    let!(:filter_category) { create(:filter_category) }
    let!(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let!(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }
    let(:account) { create(:account)}
    let(:user) { create(:account)}
    let(:favourite_search) { create(:favourite_search, account_id: account.id) }

    it "should not respond with Product#compare_product when without token" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/compare_product", :params => {
        product: product, ingredient: ingredient
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq [{:token=>"Invalid token"}]
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "GET /regenerate_master_data" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }
    let(:account) { create(:account)}
    let(:user) { create(:account)}
    let(:favourite_search) { create(:favourite_search, account_id: account.id) }

    it "should not respond with Product#regenerate_master_data when without token" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/regenerate_master_data", :params => {
        product: product, ingredient: ingredient
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq nil
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end

    it "should respond with Product#regenerate_master_data with token" do
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/regenerate_master_data", :params => {
        product: product, ingredient: ingredient, token: token
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys
      
      expect(json[:message]).to eq "Success"
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /product_calculation" do
    let(:category) { create(:category) }
    let(:filter_category) { create(:filter_category) }
    let(:filter_sub_category) { create(:filter_sub_category, filter_category_id: filter_category.id) }
    let(:product) {
      create(:product, category_id: category.id, filter_category_id: filter_category.id, filter_sub_category_id: filter_sub_category.id)
    }
    let(:ingredient) { create(:ingredient, product_id: product.id) }
    let(:health_preference) { create(:health_preference, product_id: product.id) }
    let(:account) { create(:account)}
    let(:user) { create(:account)}
    let(:favourite_search) { create(:favourite_search, account_id: account.id) }

    it "should not respond with Product#product_calculation when without token" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/bx_block_catalogue/products/product_calculation", :params => {
        product: product, ingredient: ingredient
      }, :headers => headers

      expect(response.body).to eq "<html><body>You are being <a href=\"http://www.example.com/admin\">redirected</a>.</body></html>"
      
      expect(response.content_type).to eq("text/html; charset=utf-8")
      expect(response).to have_http_status(:found)
    end
  end
end
