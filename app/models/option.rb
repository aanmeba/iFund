class Option < ApplicationRecord
  belongs_to :project

  validates :title, :description, :amount, presence: true
  validates :amount, numericality: { only_integer: true }

  # sanitise the input data
  before_save :remove_whitespace

  private

  def validate_amount
    if self.amount >= 500
      errors.add(:amount, "can't be over $500")
    end
  end

  def remove_whitespace
    self.title = self.title.strip
    self.description = self.description.strip
  end
end
