class CustomizeUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :description, :string
    add_column :users, :picture, :string
  end
end
