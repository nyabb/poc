class RenameLatAndLongToLatitudeAndLongitude < ActiveRecord::Migration
  def change
    rename_column :users, :lat, :latitude
    rename_column :users, :long, :longitude

  end
end
