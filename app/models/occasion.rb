class Occasion < ApplicationRecord
  belongs_to :gift_spec
  has_many :group_members
  belongs_to :user
  belongs_to :user_contact
end
