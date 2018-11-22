class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.references :user, foreign_key: true
      t.references :location, foreign_key: true
      t.datetime :trip_time

      t.timestamps
    end
  end
end
