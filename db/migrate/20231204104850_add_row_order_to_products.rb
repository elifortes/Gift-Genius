class AddRowOrderToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :row_order, :integer
  end
end
