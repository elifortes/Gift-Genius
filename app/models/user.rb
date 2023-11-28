class User < ApplicationRecord

  has_many :proposals
  has_many :user_answers
  has_many :answers, through: :user_answers

  has_one :personnal, dependent: :destroy
  has_one :contact, dependent: :destroy
  has_many :user_contacts, dependent: :destroy
  has_many :occasions


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
end
