class AddGiftReferenceToOccasions < ActiveRecord::Migration[7.1]
  def change
    add_reference :occasions, :gift, foreign_key: true
  end
end
