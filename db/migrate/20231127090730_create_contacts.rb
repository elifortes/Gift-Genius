class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :contact_id,null: false
      t.timestamps
    end
  end
end
