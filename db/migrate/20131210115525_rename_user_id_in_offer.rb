class RenameUserIdInOffer < ActiveRecord::Migration
  def change
    rename_column :offers, :userId, :user_id
  end
end
