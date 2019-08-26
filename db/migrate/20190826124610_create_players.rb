class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.references :user, foreign_key: true
      t.references :character, foreign_key: true
      t.boolean :is_alive
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
