class CreateGiftCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :gift_categories do |t|
      t.string :name
      t.text :categories

      t.timestamps
    end
  end
end
