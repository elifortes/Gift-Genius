class Proposal < ApplicationRecord
  belongs_to :occasion
<<<<<<< HEAD
  #belongs_to :user
=======
  belongs_to :user
>>>>>>> 7f683b0e3c6d96f7a5fe8980db7bb82253f2641b
  belongs_to :myoccasion
  has_many :products, -> { order(position: :asc) }
end
