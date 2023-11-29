class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
     # t.references :myoccasion, foreign_key: true
     #  t.integer :recipient
     #  t.integer :user
     #  t.jsonb :favorites
     #  t.text :hobbies
     #  t.text :activities
     #  t.text :channels
     #  t.text :contents
     #  t.text :brands
     #  t.text :places
     #  t.text :socials
     #  t.text :onlines
     #  t.text :purchases
     #  t.text :communications
     #  t.text :apps
     #  t.text :websites
     #  t.text :locations
     #  t.text :devices
     #  t.text :softwares
     #  t.text :games
     #  t.text :platforms
      t.timestamps
    end
  end
end
