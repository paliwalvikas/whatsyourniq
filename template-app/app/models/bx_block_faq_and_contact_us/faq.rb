module BxBlockFaqAndContactUs
  class Faq < BxBlockFaqAndContactUs::ApplicationRecord
    self.table_name = :faqs

    validates :question, presence: true, allow_blank: false
    has_many :answers, class_name: 'BxBlockFaqAndContactUs::Answer', dependent: :destroy

    accepts_nested_attributes_for :answers, :allow_destroy => true

  end
end
