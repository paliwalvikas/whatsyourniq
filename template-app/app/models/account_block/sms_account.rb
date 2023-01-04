module AccountBlock
  class SmsAccount < Account
    include Wisper::Publisher
    before_validation :parse_full_phone_number
    validates :full_phone_number, uniqueness: true, presence: true
    validate :valid_phone_number, if: :full_phone_number
    
    
    def parse_full_phone_number
      phone = Phonelib.parse(full_phone_number)
      self.full_phone_number = phone.sanitized
      self.country_code      = phone.country_code
      self.phone_number      = phone.raw_national
    end

    def valid_phone_number
      return errors.add(:full_phone_number, I18n.t('models.account_block.account.invalid_unrecognized_phone')) unless Phonelib.valid?(full_phone_number)
    end

  end
end
