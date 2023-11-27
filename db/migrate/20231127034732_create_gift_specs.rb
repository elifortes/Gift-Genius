class CreateGiftSpecs < ActiveRecord::Migration[7.1]
  def change
    create_table :gift_specs do |t|

      t.timestamps
    end
  end
end
