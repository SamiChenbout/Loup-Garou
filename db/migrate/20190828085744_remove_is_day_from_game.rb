class RemoveIsDayFromGame < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :is_day, :boolean
  end
end
