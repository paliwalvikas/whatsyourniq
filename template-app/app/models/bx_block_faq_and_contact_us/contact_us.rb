module BxBlockFaqAndContactUs
  class ContactUs < BxBlockFaqAndContactUs::ApplicationRecord
    self.table_name = :contact_us
    
    enum type: ["For Consumer" "For Business/Enterprise"]
  end
end
