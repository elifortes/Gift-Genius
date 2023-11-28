class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.references :occasion, null: false, foreign_key: true
      t.integer :contact_id
      t.timestamps
    end
  end
end
