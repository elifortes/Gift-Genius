class Product < ApplicationRecord
  include RankedModel
  belongs_to :proposal
  ranks :row_order, with_same: :proposal_id
end
