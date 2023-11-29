class AddOccasionToGifts < ActiveRecord::Migration[7.1]
  def change
    add_column :gifts, :occasion, :integer
  end
end
