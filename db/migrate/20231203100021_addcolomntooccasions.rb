class Addcolomntooccasions < ActiveRecord::Migration[7.1]
  def change
    add_column :occasions, :questions, :jsonb
    add_column :occasions, :answers, :jsonb
    add_column :occasions, :proposals, :jsonb
  end
end
