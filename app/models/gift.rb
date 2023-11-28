class Gift < ApplicationRecord
  has_many :occasions, dependent: :destroy
  belongs_to :myoccasions
end
