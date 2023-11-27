class Occasion < ApplicationRecord
  belongs_to :group
  belongs_to :gift_spec
end
