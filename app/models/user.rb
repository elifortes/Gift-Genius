class User < ApplicationRecord
  has_one :personnal, dependent: :destroy
  has_one :contact, dependent: :destroy
  has_many :user_contacts, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
