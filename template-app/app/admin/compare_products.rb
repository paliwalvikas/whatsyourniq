ActiveAdmin.register BxBlockCatalogue::CompareProduct, as: "compare" do
  filter :account_id, as: :select, collection: AccountBlock::Account.all.map {|acc| [acc.full_name, acc.id]}
  filter :product_id, as: :select, collection: BxBlockCatalogue::Product.all.map {|product| [product.product_name, product.id]}

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