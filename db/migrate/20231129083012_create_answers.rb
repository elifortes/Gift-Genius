class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.references :occasion, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :myoccasion
      t.integer :recipient
      t.integer :gift
      t.integer :user
      t.jsonb :favorites
      t.string :hobbies
      t.string :movies
      t.string :music
      t.string :books
      t.string :restaurant
      t.string :activities
      t.string :channels
      t.string :contents
      t.string :brands
      t.string :places
      t.string :socials
      t.string :onlines
      t.string :purchases
      t.string :communications
      t.string :apps
      t.string :websites
      t.string :locations
      t.string :devices
      t.string :softwares
      t.string :games
      t.string :platforms
      t.timestamps
    end
  end
end
