module BxBlockAddProfile
  class Relation < BxBlockCatalogue::ApplicationRecord
    self.table_name = :relations
    
    validates :relation, presence: true, format: { with: /[[:alpha:]]/ }
    has_many :add_profiles, class_name: 'BxBlockAddProfile::AddProfile', dependent: :destroy

  end
end

