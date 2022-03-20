class Support < ApplicationRecord
  belongs_to :project
  belongs_to :supporter, foreign_key: "supporter_id", class_name: "User"
end
