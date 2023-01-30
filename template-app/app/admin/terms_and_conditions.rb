ActiveAdmin.register BxBlockTermsAndConditions::TermAndCondition, as: "terms_and_conditions" do
  permit_params :title, :description

  index do
    selectable_column
    id_column
    column :title
    column :description
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description, as: :quill_editor
    end
    f.actions
  end
  
end
