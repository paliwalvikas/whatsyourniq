module BxBlockChat
  class AnswerOptionsController < ApplicationController
    skip_before_action :validate_json_web_token, only: [:show, :index]

    def index
      result = params[:chat_id].present? ? AnswerOption.where(chat_id: params[:chat_id]) : AnswerOption.all
      if result.present?
        render json: AnswerOptionSerializer.new(result, serialization_options).serializable_hash,
                   status: :ok
      else
        render json:  { message: "Answer Option not found" },
                       status: :unprocessable_entity
      end
    end

    def show
      ans = AnswerOption.find_by_id(params[:id] || params[:answer_option_id])
      if ans.present?
        render json: AnswerOptionSerializer.new(@chat).serializable_hash, status: :ok
      else
        render json:  { message: "Answer Option not found" },
                       status: :unprocessable_entity
      end
    end

    private

    def find_chat
      @chat = Chat.find_by(id: params[:chat_id])
    end

  end
end
