ActiveAdmin.register BxBlockCatalogue::ReportedProductQuestion, as: "Reported_Question" do
  permit_params :reported_question, reported_product_answers_attributes: %i[id reported_answer _destroy]

  form do |f|
    f.inputs do
      f.input :reported_question
      f.has_many :reported_product_answers, new_record: 'Add Answer', allow_destroy: true do |ans|
        ans.inputs do
          ans.input :reported_answer
        end
      end
    end
    f.semantic_errors :reported_product_answers
    f.actions
  end

  index title: "Reported_Question" do
    id_column
    column :reported_question
    column :created_at
    column :updated_at
    actions
  end   

  show do |data|
    attributes_table do
      row :reported_question
      panel "Answers" do     
        table_for data.reported_product_answers do
          column :id
          column :reported_answer
          column :created_at
          column :updated_at
        end
      end
      row :created_at
      row :updated_at
    end  
  end
end
