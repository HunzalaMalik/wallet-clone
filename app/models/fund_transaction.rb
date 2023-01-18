# frozen_string_literal: true

class FundTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :payee, class_name: 'User'
  belongs_to :purpose_of_payment

  scope :transactions, ->(id) { where('user_id=? OR payee_id=?', id, id) }
  scope :funds_sent, ->(id) { where('user_id=?', id) }
  scope :funds_recieved, ->(id) { where('payee_id=?', id) }
  scope :todays_total_transaction, lambda { |id|
                                     where('user_id = ? AND
                                       DATE(created_at) = DATE(?)', id, Time.zone.now)&.sum(:amount)
                                   }

  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10 }
  validate :funds_validator

  before_save :update_user_wallet
  before_save :check_transaction_limit

  def funds_validator
    if amount > User.find(user_id).wallet.amount
      errors.add(:base, 'Balance is not enough')
    elsif User.find(user_id).eql?(User.find(payee_id))
      errors.add(:base, "Sender can't be payee")
    end
  end

  def user_wallet(id)
    User.find(id).wallet
  end

  def add_payment(id)
    user_wallet(id).update(amount: User.find(id).wallet.amount + amount)
  end

  def subtract_payment(id)
    user_wallet(id).update(amount: User.find(id).wallet.amount - amount)
  end

  def update_user_wallet
    add_payment(payee_id)
    subtract_payment(user_id)
  end

  def check_transaction_limit
    return unless FundTransaction.todays_total_transaction(user_id) > 25_000

    User.find(user_id).wallet.update(amount: User.find(user_id).wallet.amount - 200)
    self.amount = amount + 200
  end
end
