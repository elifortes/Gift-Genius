class CreateOccasions < ActiveRecord::Migration[7.1]
  def change
    create_table :occasions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :myoccasion, null: false, foreign_key: true
      t.integer :recipient
      t.integer :gift
      t.timestamps
    end
  end
end
