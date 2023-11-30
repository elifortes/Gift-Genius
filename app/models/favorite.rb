class Favorite < ApplicationRecord
  belongs_to :occasion
  belongs_to :user
end
