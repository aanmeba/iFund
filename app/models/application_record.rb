class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # sanitise the input data - project & option models
  before_save :remove_whitespace

  private

  def remove_whitespace
    self.title = self.title.strip
    self.description = self.description.strip
  end
end
