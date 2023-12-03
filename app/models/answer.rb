class Answer < ApplicationRecord
  belongs_to :occasion
  belongs_to :user

  def mark_as_completedue
    self.completed = true
  end

  def completed?
    self.completed
  end
end
