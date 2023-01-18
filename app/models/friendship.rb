# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :friends, ->(id) { where('user_id=?', id) }

  validates :user_id, uniqueness: { scope: :friend_id }
  validates :nickname, presence: true, allow_blank: false,
                       format: { with: /\A[^0-9`!@#$%\^&*+_=]+\z/ }
  validate :user_exists

  def user_exists
    user = User.find(friend_id)

    return if user.present? && user.has_role?(:user)

    errors.add(:friend, "doesn't exists")
  end
end
