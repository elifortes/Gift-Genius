class Gift < ApplicationRecord
  has_many :occasions, dependent: :destroy
end
