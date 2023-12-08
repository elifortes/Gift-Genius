class Add < ActiveRecord::Migration[7.1]
  def change
    add_column :myoccasions, :selected, :boolean, default: false
    add_column :proposals, :selected, :boolean, default: false
    add_column :occasions, :selected, :boolean, default: false
    add_column :myoccasions, :selection, :jsonb
    add_column :proposals, :selection, :jsonb
    add_column :occasions, :selection, :jsonb
    add_column :users, :name, :string
    add_column :users, :birthday, :date
    add_column :users, :sex, :string
  end
end
