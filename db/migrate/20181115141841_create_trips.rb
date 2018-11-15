class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.integer :location_id
      t.datetime :trip_time

      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :location, index: true, foreign_key: true

      t.timestamps
    end
  end
end
