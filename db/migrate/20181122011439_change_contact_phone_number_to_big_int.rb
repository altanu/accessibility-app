class ChangeContactPhoneNumberToBigInt < ActiveRecord::Migration[5.2]
  def change
    change_column :contacts, :phone_number, :bigint
  end
end
