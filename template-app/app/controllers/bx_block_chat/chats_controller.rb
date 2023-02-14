# frozen_string_literal: true

module BxBlockChat
  class ChatsController < ApplicationController
    before_action :find_chat, only: [:list_of_chats]
    CHAT_TYPE = %w[Personal Lifestyle Health Nutrition]

    def index
      data = user_chat
      if data.present? && current_user.chat_answers.present?
        render json: data
      else
        render json: { message: 'Chat not found' },
               status: :unprocessable_entity
      end
    end

    def list_of_chats
      chat = ac_chat_answers
      meta = meta_for_chat
      render json: { chat: BxBlockChat::ChatSerializer.new(chat, params: serialization_options), meta: meta }
    end

    def show
      chat = Chat.find_by(id: params[:id] || params[:chat_id])
      if chat.present?
        render json: ChatSerializer.new(chat).serializable_hash,
               status: :ok
      else
        render json: { message: 'Chat not found' },
               status: :unprocessable_entity
      end
    end

    private

    def serialization_options
      { account: current_user, host: { host: request.protocol + request.host_with_port } }
    end

    def user_chat
      data = {}
      CHAT_TYPE.each do |type|
        chat_ids = Chat.chat_type(type)&.ids
        ids = current_user&.chat_answers&.where(chat_id: chat_ids)&.pluck(:chat_id)
        data[type] = ChatSerializer.new(Chat.where(id: ids), params: serialization_options)
      end
      data
    end

    def ac_chat_answers
      answer = find_answers(@chats&.ids).last
      if answer&.chat&.chat_type == params[:chat_type]
        count = @chats.where(id: 0..answer&.chat_id&.to_i).count
        @chats.first(count + 1)
      elsif params[:chat_type].downcase == 'personal'
        @chats.first(3)
      else
        @chats.first(1)
      end
    end

    def find_chat
      @chats = Chat.chat_type(params[:chat_type]).order(created_at: :asc)
    end

    def find_answers(ids)
      current_user&.chat_answers&.where(chat_id: ids).order(created_at: :asc)
    end

    def meta_for_chat
      meta = {}
      CHAT_TYPE.each do |type|
        chats = Chat.chat_type(type).order(created_at: :asc)
        chat_answers = find_answers(chats&.ids)
        val = ( chats.present? && chats&.last&.id == chat_answers&.last&.chat_id ) ? 'Completed' : 'Pending'
        meta[type] = val
      end
      meta
    end

  end
end
