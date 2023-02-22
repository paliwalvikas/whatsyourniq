require 'rails_helper'

RSpec.describe BxBlockChat::ChatsController, type: :controller do
  let(:account) { FactoryBot.create(:account) }
  let(:chat) { FactoryBot.create(:chat) }
  let(:chat_answer) { FactoryBot.create(:chat_answer, chat_id: chat.id, account_id: account.id) }

  before do
    @token = BuilderJsonWebToken.encode(account.id)
    @invalid = [{ token: 'Invalid token' }]
    @not_fount = 'Chat not found'
  end

  describe 'GET /index' do
    it "should respond with no params Chat#index" do
      get :index, params: { token: @token }
      json = JSON.parse(response.body)
      expect(json["Personal"]['data']).should_not be_nil
      expect(response).to have_http_status(:ok)
    end

    it 'should response without token Chat#index' do
      get :index, params: {}
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:errors]).to eq @invalid
    end

    it 'should Chat not found with Chat#index' do
      get :index,
          params: { token: BuilderJsonWebToken.encode(FactoryBot.create(:account, email: Faker::Internet.email).id) }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:message]).to eq(@not_fount)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'Get with #list_of_chats' do
    it 'should response wih Get #list_of_chats' do
      get :list_of_chats,  params: { token: @token, chat_type: 'Personal' }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json['data']).should_not be_nil
    end

    it 'should response without #list_of_chats' do
      get :list_of_chats,  params: { chat_type: 'Personal' }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:errors]).to eq @invalid
    end

    it 'should response chat Lifestyle #list_of_chats' do
      get :list_of_chats, params: { token: @token, chat_type: 'Lifestyle' }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json["data"]).should_not be_nil
    end
  end

  describe 'GET /show' do
    it 'should response with Chat#show' do
      get :show, params: { token: @token, id: chat.id }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:data]).should_not be_nil
      expect(response).to have_http_status(:ok)
    end

    it 'should response Chat not found with Chat#show' do
      get :show, params: { token: @token, id: 0 }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:message]).to eq(@not_fount)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'it should response without token Chat#show' do
      get :show, params: { id: 1 }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:errors]).to eq @invalid
    end
  end
end
