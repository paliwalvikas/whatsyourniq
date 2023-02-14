module BxBlockChat
  class ChatAnswersController < ApplicationController
    before_action :find_chat_ans, only: %i[show update]
    before_action :check_answer, only: %i[create]

    def create
      ans = current_user.chat_answers.new(chat_answer_params)
      if ans.save
        render json: ChatAnswerSerializer.new(ans, serialization_options).serializable_hash,
               status: :created
      else
        render json: ErrorSerializer.new(ans).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def update
      if @answer.present? && @answer.update(chat_answer_params)
        render json: ChatAnswerSerializer.new(@answer, serialization_options)
                                         .serializable_hash,
               status: :ok
      else
        render json: ErrorSerializer.new(@answer).serializable_hash,
               status: :unprocessable_entity
      end
    end

    def show
      render json: ChatAnswerSerializer.new(@answer, serialization_options).serializable_hash, status: :ok
    end

    def destroy_all_chat
      if current_user&.chat_answers&.present? && current_user&.chat_answers&.destroy_all
        render json: { success: true }, status: :ok
      else
        render json: { error: "Chat Answers not found"},
               status: :unprocessable_entity
      end
    end

    private

    def chat_answer_params
      params.permit(:chat_id, :answer_option_id, :answer, :account_id, :image)
    end

    def find_chat_ans
      @answer = ChatAnswer.find_by(id: params[:id] || params[:chat_answer_id])
    end

    def check_answer
      unless params[:image].present? || params[:answer_option_id].present? || params[:answer].present?
        render json: { error: 'Please enter any answer' }
      end
    end
  end
end
