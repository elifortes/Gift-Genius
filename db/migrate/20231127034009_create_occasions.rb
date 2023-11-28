class CreateOccasions < ActiveRecord::Migration[7.1]
  def change
    create_table :occasions do |t|
      t.string :occasion_name
      # t.references :group, null: false, foreign_key: true
      # t.references :gift_spec, null: false, foreign_key: true
      # t.integer :recipient

      t.timestamps
    end
  end
end
