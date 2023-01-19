# frozen_string_literal: true

class FundTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :payee, class_name: 'User'
  belongs_to :purpose_of_payment

  scope :transactions, ->(id) { where('user_id=? OR payee_id=?', id, id) }

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

  def add_payment(id)
    User.user_wallet(id).update!(amount: User.user_wallet(id).amount + amount)
  end

  def subtract_payment(id)
    User.user_wallet(id).update!(amount: User.user_wallet(id).amount - amount)
  end

  def update_user_wallet
    FundTransaction.transaction do
      raise ActiveRecord::Rollback unless subtract_payment(user_id)

      add_payment(payee_id)
    end
  rescue ActiveRecord::Rollback
    errors.add(:base, 'Transaction was not successful')
  end

  def self.current_days_total_transactions_amount(id)
    where('DATE(created_at) = DATE(?)', Time.zone.now).and(where(user_id: id))&.sum(:amount)
  end

  def check_transaction_limit
    return unless FundTransaction.current_days_total_transactions_amount(user_id) > 25_000

    User.find(user_id).wallet.update(amount: User.find(user_id).wallet.amount - 200)
    self.amount = amount + 200
  end
end
