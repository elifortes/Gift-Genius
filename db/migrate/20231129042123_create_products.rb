class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :proposal, foreign_key: true
      t.string :title
      t.string :description
      t.string :url
      t.integer :position
      t.boolean :selected
      t.decimal :price
      t.float :rating
      t.timestamps
    end
  end
end
