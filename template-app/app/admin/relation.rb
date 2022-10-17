ActiveAdmin.register BxBlockAddProfile::Relation, as: "Relation" do
  permit_params :relation

  index do
    selectable_column
    id_column
    column :relation
    column :created_at
    column :updated_at
    actions
  end

  filter :relation

  form do |f|
    f.inputs do
      f.input :relation
    end
    f.actions
  end

  show do
    attributes_table do
      row :relation
      row :created_at
      row :updated_at
    end
  end

end
