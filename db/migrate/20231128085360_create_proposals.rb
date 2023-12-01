class CreateProposals < ActiveRecord::Migration[7.1]
  def change
    create_table :proposals do |t|
      t.references :occasion, foreign_key: true
      t.references :myoccasion, foreign_key: true
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end
