# frozen_string_literal: true

ActiveAdmin.register BxBlockChat::Chat, as: 'chat' do
  permit_params :chat_type, :question, :answer_type,
                answer_options_attributes: %i[id option message marks chat_option_category_id title _destroy]

  scope :personal, default: true do |personal|
    personal.where(chat_type: 'Personal')
  end
  scope :health, default: true do |personal|
    personal.where(chat_type: 'Health')
  end
  scope :lifestyle, default: true do |personal|
    personal.where(chat_type: 'Lifestyle')
  end
  scope :nutrition, default: true do |personal|
    personal.where(chat_type: 'Nutrition')
  end

  index title: 'chat' do
    id_column
    column :chat_type
    column :question
    column :answer_type
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :chat_type, as: :select, collection: %w[Personal Lifestyle Health Nutrition]
      f.input :question
      f.input :answer_type, as: :select, collection: BxBlockChat::Chat.answer_types.keys
    end
    f.has_many :answer_options, new_record: 'Add Answer Options', allow_destroy: true do |val|
      val.inputs do
        val.input :option
        val.input :message
        val.input :marks
        val.input :title
        val.input :chat_option_category_id, as: :select,
                                            collection: BxBlockCategories::ChatOptionCategory.pluck(:name, :id)
      end
    end
    f.semantic_errors :answer_options
    f.actions
  end

  show do |data|
    attributes_table do
      row :id
      row :chat_type
      row :question
      row :answer_type
      panel 'Answer Options' do
        table_for data.answer_options do
          column :id
          column :option
          column :message
          column :marks
          column :created_at
          column :updated_at
        end
      end
      row :created_at
      row :updated_at
    end
  end
end
