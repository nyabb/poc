class AddNewColumnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :reactions_to, :integer
  end
end
