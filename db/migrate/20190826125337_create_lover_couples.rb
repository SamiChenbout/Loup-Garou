class CreateLoverCouples < ActiveRecord::Migration[5.2]
  def change
    create_table :lover_couples do |t|
      t.references :lover1, foreign_key: { to_table: :players }
      t.references :lover2, foreign_key: { to_table: :players }

      t.timestamps
    end
  end
end
