class CreateMycontacts < ActiveRecord::Migration[7.1]
  def change
    create_table :mycontacts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :recipient
      t.integer :contacts, array: true
      t.timestamps
    end
  end
end
