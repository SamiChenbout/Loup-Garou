class AddPointsToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :points, :integer
  end
end
