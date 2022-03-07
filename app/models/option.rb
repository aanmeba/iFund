class Option < ApplicationRecord
  belongs_to :project

  validates_format_of :title, without: /\W/, allow_blank: true
end
