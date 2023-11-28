class Occasion < ApplicationRecord
  belongs_to :gift_spec
  has_many :group_members
end
