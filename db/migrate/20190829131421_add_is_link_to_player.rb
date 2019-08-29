class AddIsLinkToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :is_link, :boolean
  end
end
