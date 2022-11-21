module BxBlockFaqAndContactUs
  class ContactUs < BxBlockFaqAndContactUs::ApplicationRecord
    self.table_name = :contact_us
    
    enum contact_type: %i[for_consumer for_business_enterprise]
    validates :contact_type, presence: true
    validates :contact_no, phone: true, presence: true 
    validates :name, :email, :message , presence: true
  end
end
