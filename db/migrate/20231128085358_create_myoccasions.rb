class CreateMyoccasions < ActiveRecord::Migration[7.1]
  def change
    create_table :myoccasions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :groups, array: true
      t.integer :recipient
      t.integer :gift
      t.timestamps
    end
  end
end
