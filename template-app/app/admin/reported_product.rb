# frozen_string_literal: true

ActiveAdmin.register BxBlockCatalogue::ReportedProduct, as: 'Reported_product' do
  actions :all, except: :new
  filter :account_id, as: :select, collection: AccountBlock::Account.all.map {|acc| [acc.full_name, acc.id]}
  filter :product_id, as: :select, collection: BxBlockCatalogue::Product.all.map {|product| [product.product_name, product.id]}
  
  permit_params :product, :account, :description, :status , :comment

  index title: 'Reported_Product' do
    selectable_column
    id_column
    column :product
    column :account
    column :description
    column :status
    actions
  end

  show do
    attributes_table do
      row :product
      row :account
      row :description
      row :status
    end
    div class: 'panel' do
      h3 'question'
      if resource.ans_ids.present?
        answers = BxBlockCatalogue::ReportedProductAnswer.where(id: resource.ans_ids)
        div class: 'panel_contents' do
          div class: 'attributes_table' do
            table do
              tbody do
                tr do
                  th do
                    'Question'
                  end
                  th do
                    'Answer'
                  end
                end
                answers.each do |ans|
                  tr do
                    td do
                      BxBlockCatalogue::ReportedProductQuestion.find_by(id: ans.reported_product_question_id)&.reported_question
                    end
                    td do
                      ans.reported_answer
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :status
      f.input :comment
    end
    f.actions
  end
end
