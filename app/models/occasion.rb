class Occasion < ApplicationRecord
  belongs_to :user
  belongs_to :myoccasion
  has_one :answer, dependent: :destroy
  has_one :question, dependent: :destroy
  has_one :proposal, dependent: :destroy
end
