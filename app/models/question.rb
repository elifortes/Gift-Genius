class Question < ApplicationRecord
  belongs_to :occasion
  belongs_to :user
end
