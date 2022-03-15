class Option < ApplicationRecord
  belongs_to :project

  validates :title, :description, :amount, presence: true
  validates :amount, numericality: { only_integer: true }

end
