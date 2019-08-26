class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :player, foreign_key: true
      t.text :content
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
