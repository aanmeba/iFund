class Option < ApplicationRecord
  belongs_to :project

  validates :title, :description, :amount, presence: true
  validates :amount, numericality: { only_integer: true }
  validate :validate_amount

  # sanitise the input data
  before_save :remove_whitespace
  before_save :remove_decimal_points

  private

  def remove_decimal_points
    self.amount = self.amount.round(-2)
  end

  def validate_amount
    if self.amount >= 50000
      errors.add(:amount, "can't be over $500.00")
    end
  end

  def remove_whitespace
    self.title = self.title.strip
    self.description = self.description.strip
  end
end
