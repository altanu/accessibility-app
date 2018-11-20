class RemoveAddressFromLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :house_number, :integer
    remove_column :locations, :street, :string
  end
end
