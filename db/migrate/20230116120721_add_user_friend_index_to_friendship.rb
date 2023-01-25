class AddUserFriendIndexToFriendship < ActiveRecord::Migration[7.0]
  def change
    add_index :friendships, %i[user_id friend_id], unique: true
  end
end
