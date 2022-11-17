module BxBlockFaqAndContactUs
  class Answer < BxBlockFaqAndContactUs::ApplicationRecord
    self.table_name = :answers

    belongs_to :faq, class_name: "BxBlockFaqAndContactUs::Faq"
    validates :answer, presence: true
  end
end
