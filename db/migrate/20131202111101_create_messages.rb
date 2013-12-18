class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_user
      t.integer :to_user
      t.string :body
      t.string :message_type
      t.boolean :read

      t.timestamps
    end
  end
end
