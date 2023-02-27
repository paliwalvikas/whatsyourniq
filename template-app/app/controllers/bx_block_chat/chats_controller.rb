# frozen_string_literal: true

module BxBlockChat
  class ChatsController < ApplicationController
    before_action :find_chat, only: [:list_of_chats]
    CHAT_TYPE = %w[Personal Lifestyle Health Nutrition].freeze

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
      meta = meta_for_chat(chat)
      meta[:profile_image] = profile_image(serialization_options)
      render json: { chat: BxBlockChat::ChatSerializer.new(chat, params: serialization_options), meta: meta }
    end

    def show
      chat = Chat.find_by(id: params[:id] || params[:chat_id])
      if chat.present?
        render json: ChatSerializer.new(chat, serialization_options).serializable_hash,
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
      if answer&.chat&.chat_type == params[:chat_type] && params[:chat_type].downcase == 'personal'
        personal_conditions(answer)
      elsif answer&.chat&.chat_type == params[:chat_type]
        count = @chats.where(id: 0..answer&.chat_id&.to_i).count
        @chats.first(count + 1)
      elsif params[:chat_type].downcase == 'personal'
        @chats.first(3)
      else
        @chats.first(1)
      end
    end

    def personal_conditions(answer)
      data = @chats.where(id: 0..answer&.chat_id&.to_i)
      pregnant = current_user.chat_answers.find_by(chat_id: data.last.id).answer_option.option
      question = @chats.first(data.count + 1)&.last&.question&.downcase&.include?('pregnant')
      if current_user.gender.downcase == 'male' && question
        @chats.first(data.count)
      elsif current_user.gender.downcase == 'female' && pregnant.downcase == 'no'
        @chats.first(data.count)
      else
        @chats.first(data.count + 1)
      end
    end

    def find_chat
      @chats = Chat.chat_type(params[:chat_type]).order(created_at: :asc)
    end

    def find_answers(ids)
      current_user&.chat_answers&.where(chat_id: ids)&.order(created_at: :asc)
    end

    def meta_for_chat(chat)
      meta = {}
      CHAT_TYPE.each do |type|
        chats = Chat.chat_type(type).order(created_at: :asc)
        if chat.last.chat_type == 'Personal' && type == 'Personal'
          chat_answers = find_answers(chat&.map(&:id))
          val = chat.present? && chat&.last&.id == chat_answers&.last&.chat_id ? 'Completed' : 'Pending'
        else
          chat_answers = find_answers(chats&.ids)
          val = chats.present? && chats&.last&.id == chat_answers&.last&.chat_id ? 'Completed' : 'Pending'
        end
        meta[type] = val
      end
      meta
    end

    def profile_image(params)
      host = params[:host][:host] || ''

      if current_user.image.attached?
        host + Rails.application.routes.url_helpers.rails_blob_url(
          current_user.image, only_path: true
        )
      end
    end
  end
end
