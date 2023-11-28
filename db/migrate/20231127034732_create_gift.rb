class CreateGift < ActiveRecord::Migration[7.1]
  def change
    create_table :gifts do |t|
      t.string :description
      t.string :title
      t.integer :price
      t.integer :price_range, array: true
     # t.references : myoccasion, foreign_key: true
      t.timestamps
    end
  end
end
