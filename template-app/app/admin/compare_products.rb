ActiveAdmin.register BxBlockCatalogue::CompareProduct, as: "compare" do
  permit_params :selected, :account_id, :product_id, :email
   actions :all, :except => [:edit, :new]


  index title: 'compare' do
    selectable_column
  	id_column
    column :selected
    column :account_id
    column :product_id
    column :email
    actions
  end   

end