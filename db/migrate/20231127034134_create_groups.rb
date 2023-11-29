class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.references :occasion, null: false, foreign_key: true
      t.integer :groups, array: true
      t.timestamps
    end
  end
end
