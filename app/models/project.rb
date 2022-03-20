class Project < ApplicationRecord
  belongs_to :category
  belongs_to :user

  # dependent: -> to avoid orphoned records
  has_many :options, dependent: :destroy
  has_many :supports, dependent: :destroy

  has_one_attached :picture, service: :amazon

  # validations
  validates :title, :description, :start_date, :due_date, :goal_amount, :category_id, presence: true
  validate :due_date_should_be_after_start_date  
  validates :goal_amount, numericality: { only_integer: true }, length: { maximum: 8, message: "is too big (maximum 6 digits)" }

  # sanitise the input data
  before_save :coder_easter_egg
  before_save :remove_whitespace
  before_save :remove_decimal_points

  private

  # the last two decimal points will be cents
  # for better and clearer calculation, remove the decimal points by rouding it
  def remove_decimal_points
    self.goal_amount = self.goal_amount.round(-2)
  end

  # due date validation
  def due_date_should_be_after_start_date
    if start_date && due_date
      if (start_date > due_date) || (due_date < Date.today)
        errors.add(:due_date, "can't be before start date and before today")
      elsif start_date == due_date
        errors.add(:due_date, "should be after start date")
      end
    end
  end
  
  # method to replace a particular word for another for fun
  def coder_easter_egg
    self.title = self.title.gsub(/welcome/i, "👻")
    self.description = self.description.gsub(/welcome/i, "👻")
  end

  # method to sanitise whitespace in title and description
  def remove_whitespace
    self.title = self.title.strip
    self.description = self.description.strip
  end
end
