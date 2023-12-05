class AddInfoToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :info, :jsonb
  end
end
