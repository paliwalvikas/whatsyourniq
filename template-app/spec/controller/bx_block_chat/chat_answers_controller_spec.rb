# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockChat::ChatAnswersController, type: :controller do
  let(:account) { create(:account) }
  let(:ex_account) { create(:account, email: Faker::Internet.email) }
  let(:chat) { create(:chat) }
  let(:answer_option) { create(:answer_option, chat_id: chat.id) }
  let(:chat_answer) do
    create(:chat_answer, chat_id: chat.id, answer_option_id: answer_option.id, account_id: account.id)
  end

  before do
    @token = BuilderJsonWebToken.encode(account.id)
    @invalid = [{ token: 'Invalid token' }]
    @not_found = 'Chat Answers not found'
  end

  describe 'Post create' do
    it 'Create Chat Answer' do
      expect do
        post :create, params: { token: @token, chat_id: chat.id, answer_option_id: answer_option.id, answer: 'Sakshi' }
      end.to change { BxBlockChat::ChatAnswer.count }
    end

    it 'Check exsisting Chat Answer' do
      post :create, params: { token: @token, chat_id: chat.id, answer_option_id: answer_option.id, answer: 'well too' }
      ans = JSON.parse(response.body)
      expect(ans['data']['attributes']['answer']).to eq 'well too'
    end
  end

  describe 'Update Chat Answer' do
    it 'Update Chat Answer' do
      patch :update, params: { token: @token, id: chat_answer.id, answer: 'vinay' }
      ans = JSON.parse(response.body)
      expect(ans['data']['attributes']['answer']).to eq 'vinay'
    end

    it 'should response with Chat Answer not found' do
      patch :update, params: { token: @token, id: 0 }
      ans = JSON.parse(response.body)
      expect(ans['data']).to be_nil
    end
  end

  describe 'Chat Answer Chat#destroy_all_chat' do
    it 'should destroy record ChatAnswer#destroy_all_chat' do
      delete :destroy_all_chat, params: { token: @token }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:success]).to eq true
    end

    it 'should destroy_all_chat without record ChatAnswer#destroy_all_chat' do
      delete :destroy_all_chat, params: { token: BuilderJsonWebToken.encode(ex_account.id) }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:error]).to eq @not_found
    end

    it 'should response without token ChatAnswer#destroy_all_chat' do
      delete :destroy_all_chat, params: { id: 0 }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:errors]).to eq @invalid
    end
  end

  describe "Chat answer Chat#destroy" do 
    it "should response Id with Chat#destroy" do 
      delete :destroy, params: { token: @token, id: chat_answer.id }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:success]).to eq true
    end 

    it 'should response without token ChatAnswer#destroy' do
      delete :destroy, params: { id: 0 }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:errors]).to eq @invalid
    end

    it 'should destroy_all_chat without record ChatAnswer#destroy_all_chat' do
      delete :destroy, params: { token: @token, id: 0 }
      json = JSON.parse(response.body).deep_symbolize_keys
      expect(json[:error]).to eq @not_found
    end
  end
end
