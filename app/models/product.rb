class Product < ApplicationRecord
  include RankedModel
  belongs_to :proposal
  acts_as_list scope: :proposal

  ranks :row_order, with_same: :proposal_id
end
