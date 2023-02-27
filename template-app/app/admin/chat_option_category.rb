# frozen_string_literal: true

ActiveAdmin.register BxBlockCategories::ChatOptionCategory, as: 'Chat Option Category' do
  permit_params :name

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  index title: 'answer option categories' do
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
  end
end
