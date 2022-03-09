class Project < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :option, dependent: :destroy

  has_one_attached :picture

  validates :title, :description, :start_date, :due_date, :goal_amount, :category_id, presence: true
  validate :due_date_should_be_after_start_date  
  validates :goal_amount, numericality: { only_integer: true }

  def due_date_should_be_after_start_date
    if start_date && due_date
      if (start_date > due_date) || (due_date < Date.today)
        errors.add(:due_date, "can't be before start date and before today")
      elsif start_date == due_date
        errors.add(:due_date, "should be after start date")
      # elsif due_date = Date.today
      #   errors.add(:due_date, "can't be today")
      end
    end
  end
  
end
