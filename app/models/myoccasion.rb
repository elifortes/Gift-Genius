class Myoccasion < ApplicationRecord
  belongs_to :user
  has_one :myoccasion, dependent: :destroy
end
