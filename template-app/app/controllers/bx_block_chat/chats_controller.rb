module BxBlockChat
  class ChatsController < ApplicationController

    def index
      data = user_chat
      if data.present? 
        render json: data
      else
        render json:  { message: "Chat not found" },
                       status: :unprocessable_entity
      end
    end

    def list_of_chats
      chats = chat_answers
      render json: BxBlockChat::ChatSerializer.new(chats,  params: serializ_options).serializable_hash,
                    status: :ok
    end


    def show
      chat = Chat.find_by(id: params[:id] || params[:chat_id])
      if chat.present?
        render json: ChatSerializer.new(chat).serializable_hash,
                      status: :ok
      else
        render json:  { message: "Chat not found" },
                      status: :unprocessable_entity
      end
    end

    private 

    def serializ_options
      { account: current_user, host: { host: request.protocol + request.host_with_port } }
    end

    def user_chat
      data = {}
      ["Personal", "Lifestyle", "Health", "Nutrition"].each do |type|
        chat_ids = Chat.where(chat_type: type)&.ids
        ids = current_user&.chat_answers&.where(chat_id: chat_ids)&.pluck(:chat_id)
        data[type] = ChatSerializer.new(Chat.where(id: ids),  params: serializ_options)
      end
      data
    end

    def chat_answers
      answer = current_user&.chat_answers&.last
      chats = Chat.where(chat_type: params[:chat_type]).order(created_at: :asc)
      if answer&.chat.chat_type == params[:chat_type]
        count = chats.where(id: 0..answer&.chat_id&.to_i).count
        chats.first(count+1)
      elsif params[:chat_type].downcase == "personal"
        chats.first(3)  
      else
        chats.first
      end
    end

  end
end
