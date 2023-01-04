ActiveAdmin.register BxBlockLanguageOptions::Language, as: 'language' do
  permit_params :language_type, :locale, :sequence, :created_at, :updated_at

  form do |f|
    f.inputs do
      f.input :language_type
      f.input :locale
      f.input :sequence
    end
    f.actions
  end

  index title: 'languages' do
    id_column
    column :language_type
    column :locale
    column :sequence
    # column :created_at
    # column :updated_at
    actions
  end   

  show do
    attributes_table do
      row :language_type
      row :locale
      row :sequence
      # row :created_at
      # row :updated_at
    end  
  end
end
