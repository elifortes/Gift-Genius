class AddReferenceToOccasion < ActiveRecord::Migration[7.1]
  def change
    add_reference :occasions, :user_contact, null: false, foreign_key: true
    add_reference :occasions, :user, null: false, foreign_key: true
  end
end
