class Project < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :supports, dependent: :destroy

  # has_one_attached :picture
  has_one_attached :picture, service: :amazon

  before_validation :dollar_to_cents

  validates :title, :description, :start_date, :due_date, :goal_amount, :category_id, presence: true
  validate :due_date_should_be_after_start_date  
  validates :goal_amount, numericality: { only_integer: true }

  def dollar_to_cents
    if !goal_amount.nil? && goal_amount != 0
      self.goal_amount = (self.attributes_before_type_cast["goal_amount"].to_f * 100).round
    end
  end

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
