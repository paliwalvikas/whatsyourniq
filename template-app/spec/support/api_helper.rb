 # spec/support/api_helper.rb
module Support
  class ApiHelper
    def self.authenticated_user(account)
      token = BuilderJsonWebToken.encode(account.id)
    end
  end
end
