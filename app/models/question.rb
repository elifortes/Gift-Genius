class Question < ApplicationRecord
  belongs_to :occasion
  belongs_to :user
  # has_one :answer #added and consider, dependent: :destroy
end
