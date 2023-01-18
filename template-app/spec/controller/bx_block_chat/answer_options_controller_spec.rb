require 'rails_helper'

RSpec.describe BxBlockChat::AnswerOptionsController, type: :controller do
  let (:chat) { FactoryBot.create(:chat) }
  let (:answer_option) { FactoryBot.create(:answer_option, chat_id: chat.id) }

  describe "GET /index" do
    it "should respond with no params AnswerOption#index" do  
      get :index
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:data]).should_not be_nil
      expect(response).to have_http_status(:unprocessable_entity)                           
    end

    it "should response with params AnswerOption#index" do 
      get :index, params: {chat_id: answer_option.chat_id }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:data]).should_not be_nil
      expect(response).to have_http_status(:ok)
    end

    it "should Chat not found with AnswerOption#index" do 
      get :index, params: {chat_id: 0}
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:message]).to eq("Answer Option not found")
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET /show" do 
    it "should response with AnswerOption#show" do
      get :show, params: {id: answer_option.id}
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:data]).should_not be_nil
      expect(response).to have_http_status(:ok)  
    end

    it "should response Chat not found with AnswerOption#show" do 
      get :show, params: {id: 0 } 
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:message]).to eq("Answer Option not found")
      expect(response).to have_http_status(:unprocessable_entity)
    end 

  end

end