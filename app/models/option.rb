class Option < ApplicationRecord
  belongs_to :project

  validates_format_of :title, without: /\W/, allow_blank: true
  validates :title, :description, :amount, presence: true
  validates :amount, numericality: { only_integer: true }

end
