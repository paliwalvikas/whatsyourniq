ActiveAdmin.register BxBlockCatalogue::ProductImportStatus, as: 'Product Import Status' do
  permit_params :id, :job_id, :status, :error_file
  menu false

  actions :all, except: [:edit, :new, :show]

  index do
    selectable_column
    id_column
    column :job_id
    column :status
    column :error_file

    column :created_at
    actions
  end

end