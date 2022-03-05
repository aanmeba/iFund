class Project < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :status

  has_one_attached :picture
end
