require 'rails_helper'

RSpec.describe "AboutContents", type: :request do
  describe "GET /about_us" do
    let(:about_content) { create(:about_content) }
    let!(:account) { create(:account) }
    
    
    it "should not respond with AboutContents#about_us_contents when without token" do                             
      headers = { "ACCEPT" => "application/json" }
      get "/about_us", :params => {
        about_content: about_content
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq [{:token=>"Invalid token"}]
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:bad_request)
    end

    it "should respond with AboutContents#about_us_contents when with token" do
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      get "/about_us", :params => {
        about_content: about_content, token: token
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:data]).not_to be_nil
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end

    it "should respond with error message when with token but not with about_content" do
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      get "/about_us", :params => {
        token: token
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:message]).to eq "About us content does not exist."
      
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
