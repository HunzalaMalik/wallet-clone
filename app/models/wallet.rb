# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :user

  validates :user, uniqueness: true
  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
