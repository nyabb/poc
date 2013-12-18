class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.date :date_of_birth
      t.string :password_digest
      t.string :phone
      t.string :mobile_phone
      t.string :adres
      t.string :zipcode
      t.string :place
      t.datetime :last_online

      t.timestamps
    end
  end
end
