class Occasion < ApplicationRecord
  belongs_to :user
  belongs_to :myoccasion
  has_one :favorite, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_one :proposal, dependent: :destroy
end
