class AddStateChasseurToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :state_chasseur, :string
  end
end
