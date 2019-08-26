class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.boolean :is_day
      t.integer :round
      t.string :step

      t.timestamps
    end
  end
end
