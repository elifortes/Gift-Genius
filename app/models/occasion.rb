class Occasion < ApplicationRecord
  belongs_to :gift
  belongs_to :user
  belongs_to :user_contact
  has_many :group_members, dependent: :destroy
end
