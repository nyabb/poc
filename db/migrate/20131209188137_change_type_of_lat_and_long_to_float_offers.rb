class ChangeTypeOfLatAndLongToFloatOffers < ActiveRecord::Migration
  def change
    change_column :offers, :latitude, :float
    change_column :offers, :longitude, :float

  end
end
