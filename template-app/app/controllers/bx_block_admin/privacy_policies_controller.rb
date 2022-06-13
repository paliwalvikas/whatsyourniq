module BxBlockAdmin
  class PrivacyPoliciesController < ApplicationController
    
    skip_before_action :verify_authenticity_token

    def privacy_policy
      @privacy = "Hello"
    end

  end
end
