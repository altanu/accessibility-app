class RemoveCoordinatesAddLatLng < ActiveRecord::Migration[5.2]
  def change
    remove_column :locations, :coordinates, :string
    add_column :locations, :lat, :decimal
    add_column :locations, :lng, :decimal
  end
end
