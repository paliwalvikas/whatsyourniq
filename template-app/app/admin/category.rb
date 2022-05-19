ActiveAdmin.register BxBlockCategories::Category, as: "category" do
  permit_params :name, :category_type
end
