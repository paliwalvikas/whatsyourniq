module BxBlockChat
  class AnswerOptionsController < ApplicationController
    skip_before_action :validate_json_web_token, only: [:show, :index]

    def index
      data = AnswerOption.all
      render json: AnswerOptionSerializer.new(data, serialization_options).serializable_hash,
                   status: :ok
    end

    def show
      render json: AnswerOptionSerializer.new(@chat).serializable_hash, status: :ok
    end

    private

    def find_chat
      @chat = Chat.find_by(id: params[:chat_id])
    end

  end
end
