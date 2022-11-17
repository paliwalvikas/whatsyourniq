module BxBlockFaqAndContactUs
  class ErrorSerializer < BuilderBase::BaseSerializer
    attribute :errors do |catalogue|
      catalogue.errors.as_json
    end
  end
end
