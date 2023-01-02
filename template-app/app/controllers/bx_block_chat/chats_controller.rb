module BxBlockChat
  class ChatsController < ApplicationController
    skip_before_action :validate_json_web_token, only: [:show, :index]
    before_action :find_record , only: %i[index]

    def index
      if @chats.present? 
        render json: ChatSerializer.new(@chats&.order(created_at: :asc)).serializable_hash, status: :ok
      else
        render json:  { message: "Chat not found" },
                       status: :unprocessable_entity
      end
    end

    def show
      chat = Chat.find_by(id: params[:id] || params[:chat_id])
      render json: ChatSerializer.new(chat).serializable_hash, status: :ok
    end

    private 

    def find_record
      @chats =  if params[:chat_type].present?
                  Chat.where(chat_type: params[:chat_type])
                else
                  Chat.all
                end
      @chats
    end

  end
end
