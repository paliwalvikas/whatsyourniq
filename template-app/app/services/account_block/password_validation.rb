module AccountBlock
  class PasswordValidation
    include ActiveModel::Validations

    attr_reader :password

    class << self
      def regex
        # ^                                       Start anchor
        # (?=.*[A-Z])                             Has one uppercase letter
        # (?=.*[!@#$&*?<>',\[\]}{=\-)(^%`~+.:;_]) Has one special case symbol
        # (?=.*[0-9])                             Has one digit
        # (?=.*[a-z])                             Has one lowercase letter
        # .{8,}                                   Is at least length 8
        # $                                       End anchor
        /^(?=.*[A-Z])(?=.*[#!@$&*?<>',\[\]}{=\-)(^%`~+.:;_])(?=.*[0-9])(?=.*[a-z]).{8,}$/
      end

      def regex_string
        regex.to_s.sub('(?-mix:', '').delete_suffix(')')
      end

      def rules
        I18n.t('services.account_block.password_validation.password_should_minimum') +
        I18n.t('services.account_block.password_validation.contain_uppercase_lowercase') +
        I18n.t('services.account_block.password_validation.least_one_digit') +
        '(!@#$&*?<>\',[]}{=-)(^%`~+.:;_).'
      end
    end

    validates :password, :format => {
      :with      => regex,
      :multiline => true,
    }

    def initialize(password)
      @password = password
    end
  end
end
