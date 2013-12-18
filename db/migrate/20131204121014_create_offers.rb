class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string  :title
      t.integer :userId
      t.string  :message
      t.float  :latitude
      t.float :longitude
      t.boolean :fulfilled
      t.string  :offer_type
      t.timestamps
    end
  end
end
