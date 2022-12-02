ActiveAdmin.register BxBlockCatalogue::RequestedProduct, as: "Requested_product" do
  permit_params :product, :account, :description

  index title: "Requested_product" do
    selectable_column
    id_column
    column :name
    column :account
    column :weight
    column :refernce_url
    column :status
    column :category
     column "images" do |obj|
      if obj.product_image.present?
        obj.product_image.each do |img|
          span do 
            link_to(image_tag(img))
          end
        end
      end
    end
    column :barcode_image do |obj|
      if obj.product_image.present?
        obj.product_image.each do |img|
          span do 
            link_to(image_tag(img))
          end
        end
      end
    end
  actions
  end   
end
