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
  # before_validation :dollar_to_cents, if: :goal_amount_changed?

  private

  def remove_decimal_points
    self.goal_amount = self.goal_amount.round(-2)
  end

  # def dollar_to_cents
  #   if !goal_amount.nil? && goal_amount != 0
  #     self.goal_amount = (self.attributes_before_type_cast["goal_amount"].to_f * 100).round
  #   end
  # end

  def due_date_should_be_after_start_date
    if start_date && due_date
      if (start_date > due_date) || (due_date < Date.today)
        errors.add(:due_date, "can't be before start date and before today")
      elsif start_date == due_date
        errors.add(:due_date, "should be after start date")
      end
    end
  end
  
  def coder_easter_egg
    self.title = self.title.gsub(/welcome/i, "👻")
    self.description = self.description.gsub(/welcome/i, "👻")
  end

  def remove_whitespace
    self.title = self.title.strip
    self.description = self.description.strip
  end
end
