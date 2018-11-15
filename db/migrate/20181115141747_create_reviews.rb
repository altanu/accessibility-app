class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :location_id
      t.boolean :wheel_chair
      t.text :description
      t.integer :rating

      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :location, index: true, foreign_key: true

      t.timestamps
    end
  end
end
