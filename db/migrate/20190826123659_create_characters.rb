class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :photo
      t.string :description
      t.string :name

      t.timestamps
    end
  end
end
