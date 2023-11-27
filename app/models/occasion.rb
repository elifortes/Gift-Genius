class Occasion < ApplicationRecord
  belongs_to :group
  belongs_to :gift_spec
  # belongs_to :recipient
end
