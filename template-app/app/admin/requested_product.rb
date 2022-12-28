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

   show do
    attributes_table do
      row :name
      row :account_id
      row :weight
      row :refernce_url
      row :status
      row :category
      row 'product_image' do |ad|
        ad.product_image.each.map do |image, index|
          image_tag(url_for(image),style: 'height:50px; width:50px')
        end
      end
      row 'barcode_image' do |ad|
        ad.barcode_image.each.map do |image, index|
          image_tag(url_for(image), :class => "img_preview", style: 'height:50px; width:50px')
        end
      end
    end  
  end
end
