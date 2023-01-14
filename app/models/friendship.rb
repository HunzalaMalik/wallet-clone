# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :friends, ->(id) { where('user_id=?', id) }

  validates :nickname, presence: true, allow_blank: false,
                       format: { with: /\A[^0-9`!@#$%\^&*+_=]+\z/ }
end
