class AddContentToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :content, :text
  end
end
