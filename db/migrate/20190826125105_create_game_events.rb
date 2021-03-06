class CreateGameEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :game_events do |t|
      t.references :game, foreign_key: true
      t.references :actor, foreign_key: { to_table: :players }
      t.references :target, foreign_key: { to_table: :players }
      t.string :event_type
      t.integer :round

      t.timestamps
    end
  end
end
