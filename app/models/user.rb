class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects

  # set user's type
  def organiser?
    type == "Organiser"
  end

  def supporter?
    type == "Supporter"
  end
end
