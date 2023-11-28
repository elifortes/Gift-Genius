class CreateGroupMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :group_members do |t|
      t.references :user_contact, null: false, foreign_key: true
      t.references :occasion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
