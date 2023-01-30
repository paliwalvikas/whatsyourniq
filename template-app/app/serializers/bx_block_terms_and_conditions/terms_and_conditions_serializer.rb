module BxBlockTermsAndConditions
  class TermsAndConditionsSerializer < BuilderBase::BaseSerializer
    attributes :id, :title, :description, :created_at, :updated_at
  end
end

