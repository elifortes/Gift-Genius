class Proposal < ApplicationRecord
  belongs_to :occasion
  belongs_to :user
  belongs_to :myoccasion
  has_many :products, -> { order(position: :asc) }
end
