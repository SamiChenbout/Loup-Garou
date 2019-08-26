class CreateLoverCouples < ActiveRecord::Migration[5.2]
  def change
    create_table :lover_couples do |t|
      t.references :lover1, foreign_key: true
      t.references :lover2, foreign_key: true

      t.timestamps
    end
  end
end
