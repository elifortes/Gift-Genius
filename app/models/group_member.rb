class GroupMember < ApplicationRecord
  belongs_to :user_contact
  belongs_to :occasion
end
