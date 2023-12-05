class AddNotificationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :notification, :boolean
  end
end
