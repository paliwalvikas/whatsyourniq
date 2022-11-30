ActiveAdmin.register BxBlockCatalogue::FavouriteProduct, as: "favourite_product" do
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
