class AddLatAndLongAndRadiusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lat, :string
    add_column :users, :long, :string
    add_column :users, :radius, :string
  end
end
