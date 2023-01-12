# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend,  class_name: 'User'

  validates :nickname, presence: true, allow_blank: false,
                       format: { with: /\A[^0-9`!@#$%\^&*+_=]+\z/ }
end
