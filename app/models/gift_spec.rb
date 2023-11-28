class GiftSpec < ApplicationRecord
  has_many :occasions, dependent: :destroy
end
