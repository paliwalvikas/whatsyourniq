ActiveAdmin.register BxBlockCatalogue::ProductImportStatus, as: 'Product Import Status' do
  permit_params :id, :job_id, :status, :error_file
  menu false

  actions :all, except: [:edit, :new, :show]

  index do
    selectable_column
    id_column
    column :job_id
    column :status
    column :created_at
    actions defaults: false do |report|
      link_to 'Download report', download_admin_product_import_status_path(report, format: :csv) unless report.status == "In-Progress"
    end
  end

  member_action :download, method: :get do
    status = BxBlockCatalogue::ProductImportStatus.find_by(id: params[:id])
    csv_data = CSV.parse(status.file_status)
    csv_file = CSV.generate( encoding: 'Windows-1251' ) do |csv|
      csv_data.each do |data|
        csv << data
      end
    end
    send_data csv_file, type: 'text/csv; charset=utf-8; header=present', disposition: "attachment; filename=data_import_report.csv"
  end

end