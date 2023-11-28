class CreatePersonnals < ActiveRecord::Migration[7.1]
  def change
    create_table :personnals do |t|
      t.string :name
      t.date :birthday
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
