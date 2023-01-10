module BxBlockContentManagement
  class Exam < ApplicationRecord
    self.table_name = :exams

    validates_presence_of :heading, :to, :from

    validate :check_to_and_from

    def name
      heading
    end

    private

    def check_to_and_from
      if self.to.present? && self.from.present? && self.to < self.from
        errors.add(:from, I18n.t('models.bx_block_content_management.exam.can_not_greater'))
      end
    end
  end
end
