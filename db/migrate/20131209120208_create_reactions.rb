class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.string :react_type
      t.integer :react_to
      t.string :message
      t.integer :userId

      t.timestamps
    end
  end
end
