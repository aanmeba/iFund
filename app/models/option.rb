class Option < ApplicationRecord
  belongs_to :project

  validates :title, :description, :amount, presence: true
  validates :amount, numericality: { only_integer: true }

  private

  def validate_amount
    if self.amount >= 500
      errors.add(:amount, "can't be over $500")
    end
  end

end
