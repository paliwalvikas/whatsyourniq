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
end