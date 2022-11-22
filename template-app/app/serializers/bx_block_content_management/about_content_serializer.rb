module BxBlockContentManagement
  class AboutContentSerializer < BuilderBase::BaseSerializer
    attributes :id, :title, :description, :created_at, :updated_at
  end
end