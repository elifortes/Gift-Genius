class User < ApplicationRecord
  has_one :personnal, dependent: :destroy
  has_one :mycontact, dependent: :destroy
  # group gift created by user.
  has_many :myoccasions, dependent: :destroy
  # group gift he is a member.
  has_many :occasions, dependent: :destroy
  # information about the recipient
  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy

  # devise stuff
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
