class CreateCompanions < ActiveRecord::Migration[5.2]
  def change
    create_table :companions do |t|
      t.references :trip, foreign_key: true
      t.references :contact, foreign_key: true
      t.string :name
      t.string :email
      t.bigint :phone_number

      t.timestamps
    end
  end
end
