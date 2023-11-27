class Occasion < ApplicationRecord
  belongs_to :gift_spec
  has_many :groups
end
