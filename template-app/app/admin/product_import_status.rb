ActiveAdmin.register BxBlockCatalogue::ImportStatus, as: 'Import Status' do
  permit_params :id, :job_id, :status, :error_file
  menu false

  actions :all, except: [:edit, :new, :show]

  action_item :import_status, only: :index do
    link_to 'Refresh', '',class: 'refresh-button', onclick: "reload;"
  end


  index do
    selectable_column
    id_column
    column :job_id
    column :status
    column :record_file_contain
    column :record_uploaded
    column :record_failed
    column :calculation_status
    column :created_at
    actions defaults: false do |report|
      link_to 'Download report', download_admin_import_status_path(report, format: :csv) unless report&.file_status.nil?
    end
  end

  member_action :download, method: :get do
    status = BxBlockCatalogue::ImportStatus.find_by(id: params[:id])
    csv_data = CSV.parse(status.file_status)
    csv_file = CSV.generate( encoding: 'utf-8' ) do |csv|
      csv_data.each do |data|
        csv << data
      end
    end
    send_data csv_file, type: 'text/csv; charset=utf-8; header=present', disposition: "attachment; filename=data_import_report.csv"
  end

end