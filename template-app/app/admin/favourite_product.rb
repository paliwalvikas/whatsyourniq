ActiveAdmin.register BxBlockCatalogue::FavouriteProduct, as: "favourite_product" do
  filter :account_id, as: :select, collection: AccountBlock::Account.all.map {|acc| [acc.full_name, acc.id]}
  filter :product_id, as: :select, collection: BxBlockCatalogue::Product.all.map {|product| [product.product_name, product.id]}

  permit_params :account_id, :product_id, :favourite
  actions :all, :except => [:new, :edit]
  index do
    selectable_column
    id_column
    column :account
    column :product
    actions
  end

  show do
    attributes_table do
      row :account
      row :product
    end
  end

end
