module BxBlockAddProfile
  class Relation < BxBlockCatalogue::ApplicationRecord
    self.table_name = :relations
    
    validates :relation, presence: true
    has_one :add_profile, class_name: 'BxBlockAddProfile::AddProfile', dependent: :destroy

  end
end

