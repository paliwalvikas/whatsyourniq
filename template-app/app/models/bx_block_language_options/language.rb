module BxBlockLanguageOptions
  class Language < ApplicationRecord
    self.table_name = :languages

    # validates :name, :language_code, uniqueness: {case_sensitive: false}, presence: true
    validates :language_type, uniqueness: true, presence: true, format: { with: /[[:alpha:]]/ }
    validates :locale, uniqueness: true, presence: true, format: { with: /[[:alpha:]]/ }

    scope :content_languages, -> { where("is_content_language is true") }
    scope :app_languages, -> { where("is_app_language is true") }

    has_many :contents_languages,
             class_name: "BxBlockLanguageOptions::ContentLanguage",
             join_table: "contents_languages", dependent: :destroy
    has_many :accounts,
             class_name: "AccountBlock::Account",
             through: :contents_languages, join_table: "contents_languages"

    # after_commit :update_available_locales

    private

    def update_available_locales
      BxBlockLanguageOptions::SetAvailableLocales.call
    end

  end
end
