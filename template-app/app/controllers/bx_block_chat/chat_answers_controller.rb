# frozen_string_literal: true

module BxBlockChat
  class ChatAnswersController < ApplicationController
    before_action :find_chat_ans, only: %i[show update destroy]
    before_action :check_answer, only: %i[create]
    NOT_FOUND = 'Chat Answers not found'

    def create
      create_answer if params[:answer_option_id].instance_of?(Array)
      ans = current_user.chat_answers.new(chat_answer_params)
      begin
        if ans.save
          render json: ChatAnswerSerializer.new(ans, serialization_options).serializable_hash,
                 status: :created
        else
          render json: ErrorSerializer.new(ans).serializable_hash,
                 status: :unprocessable_entity
        end
      rescue AbstractController::DoubleRenderError
        nil
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
        render json: { error: NOT_FOUND },
               status: :unprocessable_entity
      end
    end

    def destroy
      if @answer.present? && @answer.destroy
        render json: { success: true }, status: :ok
      else
        render json: { error: NOT_FOUND },
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

    def create_answer
      params[:answer_option_id].each do |ans_id|
        current_user.chat_answers.create(chat_id: params[:chat_id], answer_option_id: ans_id)
      end
      render json: ChatAnswerSerializer.new(current_user.chat_answers.where(chat_id: params[:chat_id]),
                                            serialization_options).serializable_hash
    end

    def check_answer
      unless params[:image].present? || params[:answer_option_id].present? || params[:answer].present?
        render json: { error: 'Please enter any answer' }
      end
    end
  end
end
