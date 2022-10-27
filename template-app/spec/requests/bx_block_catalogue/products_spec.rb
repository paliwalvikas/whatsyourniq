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
    let(:account) { create(:account)}

    it "should respond with Product#change_for_cal" do                             
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
end