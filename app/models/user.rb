class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects
  # has_many :supported_projects, foreign_key: "organiser_id", class_name: "Support"
  # has_many :supporting_projects, foreign_key: "supporter_id", class_name: "Support"

  def organiser?
    type == "Organiser"
  end

  def supporter?
    type == "Supporter"
  end
end
