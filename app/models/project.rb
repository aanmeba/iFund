class Project < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :option, dependent: :destroy

  has_one_attached :picture
end
