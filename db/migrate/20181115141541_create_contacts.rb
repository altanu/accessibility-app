class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :phone_number
      t.boolean :emergency

      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
