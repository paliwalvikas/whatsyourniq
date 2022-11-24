ActiveAdmin.register BxBlockFaqAndContactUs::Faq, as: "FQA_Question" do
  permit_params :question, answers_attributes: %i[id answer _destroy]

  form do |f|
    f.inputs do
      f.input :question
      f.has_many :answers, new_record: 'Add Answer', allow_destroy: true do |ans|
        ans.inputs do
          ans.input :answer
        end
      end
    end
    f.actions
  end

  index title: "Faqs" do
    id_column
    column :question
    column :created_at
    column :updated_at
    actions
  end   

  show do |data|
    attributes_table do
      row :question
      panel "Answers" do     
        table_for data.answers do
          column :id
          column :answer
          column :created_at
          column :updated_at
        end
      end
      row :created_at
      row :updated_at
    end  
  end
end
