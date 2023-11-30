class User < ApplicationRecord
  has_many :proposals
  has_many :user_answers
  has_many :answers, through: :user_answers

  has_one :mycontact, dependent: :destroy
  has_one :personnal, dependent: :destroy
  # group gift created by user.
  has_many :myoccasions, dependent: :destroy
  # group gift he is a member.
  has_many :occasions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :profiles, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
end
