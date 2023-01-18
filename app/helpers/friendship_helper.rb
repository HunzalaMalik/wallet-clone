# frozen_string_literal: true

module FriendshipHelper
  def friend_email(id)
    User.find(id).email
  end
end
