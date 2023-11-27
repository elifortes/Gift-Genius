class CreateOccasions < ActiveRecord::Migration[7.1]
  def change
    create_table :occasions do |t|
      t.string :group_name
      t.references :group, null: false, foreign_key: true
      t.references :gift_spec, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
