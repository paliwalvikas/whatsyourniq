ActiveAdmin.register BxBlockCatalogue::RequestedProduct, as: "Requested_product" do
  permit_params :product, :account, :description
  config.filters = false 

  

  index title: "Requested_product" do
    selectable_column
    id_column
    column :name
    column :account_id
    column :weight
    column :refernce_url
    column :status
    column :category
    actions
  end   
end
