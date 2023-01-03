ActiveAdmin.register BxBlockChat::Chat, as: 'chat' do
  permit_params :chat_type, :question, answer_options_attributes: %i[id option _destroy]

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
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :chat_type, as: :select, collection: %w[Personal Lifestyle Health Nutrition]
      f.input :question
    end
    f.has_many :answer_options, new_record: 'Add Answer Options', allow_destroy: true do |val|
      val.inputs do
        val.input :option
      end
    end
    f.actions
  end

  show do |data|
    attributes_table do
      row :id
      row :chat_type
      row :question
      panel 'Answer Options' do
        table_for data.answer_options do
          column :id
          column :option
          column :created_at
          column :updated_at
        end
      end
      row :created_at
      row :updated_at
    end
  end
end
