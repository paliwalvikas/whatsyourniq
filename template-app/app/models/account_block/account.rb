# frozen_string_literal: true

module AccountBlock
  class Account < AccountBlock::ApplicationRecord
    self.table_name = :accounts
    include Wisper::Publisher
    attr_accessor :image_url

    # has_secure_password
    has_one_attached :image
    before_validation :parse_full_phone_number
    before_create :generate_api_key
    has_many :favourite_searches, class_name: 'BxBlockCatalogue::FavouriteSearch', dependent: :destroy
    has_one :blacklist_user, class_name: 'AccountBlock::BlackListUser', dependent: :destroy
    after_save :set_black_listed_user
    has_many :favourite_products, class_name: 'BxBlockCatalogue::FavouriteProduct', dependent: :destroy
    has_many :compare_products, class_name: 'BxBlockCatalogue::CompareProduct', dependent: :destroy
    # has_many :members, class_name: 'AccountBlock::Member', dependent: :destroy
    # has_many :addresses, class_name: 'BxBlockAddress::Address', as: :addressble, dependent: :destroy
    has_many :orders, class_name: 'BxBlockCatalogue::Order', dependent: :destroy
    has_many :add_profiles, class_name: 'BxBlockAddProfile::AddProfile', dependent: :destroy
    has_many :requested_products, class_name: 'BxBlockCatalogue::RequestedProduct', foreign_key: 'account_id', dependent: :destroy
    has_many :reported_products, class_name: 'BxBlockCatalogue::ReportedProduct', foreign_key: 'account_id', dependent: :destroy
    has_many :chat_answers, class_name: 'BxBlockChat::ChatAnswer', dependent: :destroy
    before_save :image_process, if: :image_url
    enum status: %i[regular suspended deleted]
    enum gender: %i[female male other]
    scope :active, -> { where(activated: true) }
    scope :existing_accounts, -> { where(status: %w[regular suspended]) }

    private

    def parse_full_phone_number
      phone = Phonelib.parse(full_phone_number)
      self.full_phone_number = phone.sanitized
      self.country_code      = phone.country_code
      self.phone_number      = phone.raw_national
    end

    def valid_phone_number
      errors.add(:full_phone_number, I18n.t('models.account_block.account.invalid_unrecognized_phone')) unless Phonelib.valid?(full_phone_number)
    end

    def generate_api_key
      loop do
        @token = SecureRandom.base64.tr('+/=', 'Qrt')
        break @token unless Account.exists?(unique_auth_id: @token)
      end
      self.unique_auth_id = @token
    end

    def set_black_listed_user
      if is_blacklisted_previously_changed?
        if is_blacklisted
          AccountBlock::BlackListUser.create(account_id: id)
        else
          blacklist_user.destroy
        end
      end
    end

    def image_process
      begin
        file = open(image_url)
      rescue Errno::ENOENT, OpenURI::HTTPError, Errno::ENAMETOOLONG, Net::OpenTimeout
        file = open('lib/image_not_found.jpeg')
      end
      image.attach(io: file, filename: 'some-image.jpg', content_type: 'image/jpg')
    end
  end
end
