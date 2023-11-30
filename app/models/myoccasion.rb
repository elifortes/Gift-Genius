class Myoccasion < ApplicationRecord
  belongs_to :user

  has_many :occasions, dependent: :destroy
  has_one_attached :photo
end
