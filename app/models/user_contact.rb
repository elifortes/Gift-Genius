class UserContact < ApplicationRecord
  belongs_to :contact
  belongs_to :user
  has_many :group_members
  has_many :occasions
end
