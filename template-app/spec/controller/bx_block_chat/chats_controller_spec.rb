require 'rails_helper'

RSpec.describe BxBlockChat::ChatsController, type: :controller do
  let (:chat) { FactoryBot.create(:chat) }

  describe "GET /index" do
    it "should respond with no params Chat#index" do  
      get :index, params: { data: {language_id: BxBlockLanguageOptions::Language.last.id}}
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:data]).should_not be_nil
      expect(response).to have_http_status(:ok)                           
    end

    it "should response with params Chat#index" do 
      get :index, params: {chat_type: 'Personal', page: 1 , data: {language_id: BxBlockLanguageOptions::Language.last.id}}
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:data]).should_not be_nil
      expect(response).to have_http_status(:ok)
    end

    it "should Chat not found with Chat#index" do 
      get :index, params: {chat_type: 'Non',  data: {language_id: BxBlockLanguageOptions::Language.last.id}}
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:message]).to eq("Chat not found")
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /show" do 
    it "should response with Chat#show" do
      get :show , params: {id: chat.id,  data: {language_id: BxBlockLanguageOptions::Language.last.id}}
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:data]).should_not be_nil
      expect(response).to have_http_status(:ok)  
    end

    it "should response Chat not found with Chat#show" do 
      get :show , params: {id: 0,  data: {language_id: BxBlockLanguageOptions::Language.last.id}}
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:message]).to eq("Chat not found")
      expect(response).to have_http_status(:unprocessable_entity)
    end 
  end

end