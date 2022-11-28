require 'rails_helper'

RSpec.describe "AddProfiles", type: :request do
  describe "POST /calculate_bmi" do
    let(:relation) { create(:relation) }
    let(:account) { create(:account) }
    let(:add_profile) {
      create(:add_profile, relation_id: relation.id, account_id: account.id)
    }
    
    it "should not respond to AddProfiles#calculate_bmi without token" do                             
      headers = { "ACCEPT" => "application/json" }
      post "/add_profiles/calculate_bmi", :params => {        
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:errors]).to eq [{:token=>"Invalid token"}]

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:bad_request)
    end

    it "should respond to AddProfiles#calculate_bmi with token but without profile" do
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      post "/add_profiles/calculate_bmi", :params => {
        token: token
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:message]).to eq "Profile doesn't exists for provided Id"

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should respond to AddProfiles#calculate_bmi with token and with profile" do
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      post "/add_profiles/calculate_bmi", :params => {
        token: token, profile_id: add_profile.id
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:message]).to eq "Please provide the requierd details"

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should respond to AddProfiles#calculate_bmi with token and with profile and not calculate bmi with invalid params" do
      token = Support::ApiHelper.authenticated_user(account)

      headers = { "ACCEPT" => "application/json" }
      post "/add_profiles/calculate_bmi", :params => {
        token: token, profile_id: add_profile.id, height: 1.70, weight: 88
      }, :headers => headers

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:data]).should_not be_nil

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end
end
