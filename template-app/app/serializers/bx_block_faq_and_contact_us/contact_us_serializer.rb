module BxBlockFaqAndContactUs
  class ContactUsSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer
    attributes *[
      :id,
      :contact_type, 
      :business_name, 
      :name, 
      :email, 
      :contact_no, 
      :message,
      :created_at,
      :updated_at,
    ]

  end

end
