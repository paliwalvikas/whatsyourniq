module BxBlockLanguageOptions
  class LanguageSerializer < BuilderBase::BaseSerializer
    attributes :id, :language_type, :locale, :sequence, :created_at, :updated_at
  end
end
