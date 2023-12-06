class AddNotificationsToPersonnals < ActiveRecord::Migration[7.1]
  def change
    add_column :personnals, :notifications, :boolean, default: false
  end
end
