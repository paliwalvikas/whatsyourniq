require 'rails_helper'

RSpec.describe BxBlockChat::ChatAnswersController, type: :controller do
  let(:account) { create(:account) }
  let(:chat) { create(:chat) }
  let(:answer_option) { create(:answer_option, chat_id: chat.id) }
  let(:chat_answer) { create(:chat_answer, chat_id: chat.id, answer_option_id: answer_option.id, account_id: account.id) }

  before do
    @token = BuilderJsonWebToken.encode(account.id)
  end

  describe 'Get #index' do
    it "should response with ChatAnswer#index" do 
      get :index, params: { token: @token, chat_type: answer_option.chat.chat_type }
      json = JSON.parse(response.body)
      expect(json["data"]).not_to be_nil
      expect(response).to have_http_status(:ok)
    end
  end

  describe "Post create" do
    it 'Create Chat Answer' do
      expect do
        post :create, params: { token: @token, chat_id: chat.id, answer_option_id: answer_option.id, answer: "Sakshi" }
      end.to change { BxBlockChat::ChatAnswer.count }
    end

    it 'Check exsisting Chat Answer'do
      post :create, params: {token: @token, chat_id: chat.id, answer_option_id: answer_option.id, answer: "well too" }
      ans = JSON.parse(response.body)
      expect(ans['data']['attributes']['answer']).to eq "well too"
    end
  end

  describe 'Update Chat Answer' do 
    it 'Update Chat Answer' do
      patch :update, params: {token: @token, id: chat_answer.id, answer: "vinay"}
      ans = JSON.parse(response.body)
      expect(ans['data']['attributes']['answer']).to eq "vinay"
    end

    it 'should response with Chat Answer not found' do 
      patch :update, params: {token: @token, id: 0}
      ans = JSON.parse(response.body)
      expect(ans["data"]).to be_nil
    end
  end

end
