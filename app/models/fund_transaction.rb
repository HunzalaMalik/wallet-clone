# frozen_string_literal: true

class FundTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :payee, class_name: 'User'
  belongs_to :purpose_of_payment

  scope :transactions, ->(id) { where('user_id=? OR payee_id=?', id, id) }

  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
