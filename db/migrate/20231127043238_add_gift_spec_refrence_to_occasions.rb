class AddGiftSpecRefrenceToOccasions < ActiveRecord::Migration[7.1]
  def change
    add_reference :occasions, :gift_spec, null: false, foreign_key: true
  end
end
