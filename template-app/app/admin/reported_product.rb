ActiveAdmin.register BxBlockCatalogue::ReportedProduct, as: "Reported_product" do
  permit_params :product, :account, :description

  index title: "Reported_Question" do
    selectable_column
    id_column
    column :product
    column :account
    column :description
    column :question do |obj|
      obj&.ans_ids.each do |ans|
        ans = BxBlockCatalogue::ReportedProductAnswer.find_by_id(ans) if ans.present?
        @question = BxBlockCatalogue::ReportedProductQuestion.find_by(id: ans.reported_product_question_id) if ans.present?
      end
      @question
    end
    actions
  end   
end
