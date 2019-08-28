class AddRoundStepToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :round_step, :string
  end
end
