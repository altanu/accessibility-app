class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.integer :house_number
      t.string :street
      t.integer :wheelchair
      t.boolean :bathroom
      t.boolean :parking
      t.string :coordinates

      t.timestamps
    end
  end
end
