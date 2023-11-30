class CreateGift < ActiveRecord::Migration[7.1]
  def change
    create_table :gifts do |t|
      t.jsonb :div
      t.integer :price
      t.string  :occasion
      t.string  :title
      t.timestamps
    end
  end
end
