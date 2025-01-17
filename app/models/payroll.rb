class Payroll < ApplicationRecord
  scope :ordered, -> { order(starts_at: :desc) }

  validates :starts_at, :ends_at, presence: true
  validate :ends_at_not_in_future

  private

  def ends_at_not_in_future
    errors.add(:ends_at, 'must be in the past') if ends_at.future?
  end
end
