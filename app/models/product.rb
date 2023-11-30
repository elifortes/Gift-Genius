class Product < ApplicationRecord
  belongs_to :proposal
  acts_as_list scope: :proposal
end
