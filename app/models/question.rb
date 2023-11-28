class Question < ApplicationRecord
  has_many :user_answers
  has_many :answers
end
