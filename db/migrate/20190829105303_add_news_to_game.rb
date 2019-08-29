class AddNewsToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :news, :text
  end
end
