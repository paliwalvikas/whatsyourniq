module BxBlockFaqAndContactUs
  class Faq < BxBlockFaqAndContactUs::ApplicationRecord
    self.table_name = :faqs

    validates :question,presence: true, allow_blank: false, format: { with: /[[:alpha:]]/ }
    has_many :answers, class_name: 'BxBlockFaqAndContactUs::Answer', dependent: :destroy

    accepts_nested_attributes_for :answers, :allow_destroy => true
    validate :should_have_answers

    private

    def should_have_answers
       errors.add(:base, "At least one answer option is required.") if answers.blank?
    end

  end
end
