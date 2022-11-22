ActiveAdmin.register BxBlockCatalogue::CompareProduct, as: "compare" do
  permit_params :selected, :account_id, :product_id, :email
   actions :all, :except => [:edit, :new]


  index title: 'compare' do
    selectable_column
  	id_column
    column :selected
    column :account
    column :product do |obj|
      obj&.product&.product_name
    end
    actions
  end   

end