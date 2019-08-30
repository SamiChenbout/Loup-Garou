class AddGameToLoverCouple < ActiveRecord::Migration[5.2]
  def change
    add_reference :lover_couples, :game, foreign_key: true
  end
end
