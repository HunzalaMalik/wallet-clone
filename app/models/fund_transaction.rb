# frozen_string_literal: true

class FundTransaction < ApplicationRecord
  attr_accessor :payee_info

  belongs_to :user
  belongs_to :payee, class_name: 'User'
  belongs_to :purpose_of_payment

  scope :transactions, ->(id) { where('user_id=? OR payee_id=?', id, id) }

  validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10 }
  validates_with FundValidator

  before_save :update_user_wallet
  before_save :check_transaction_limit
  before_validation :set_payee

  def update_user_wallet
    FundsTransactionService.new(self).transaction
  end

  def check_transaction_limit
    FundsTransactionService.new(self).check_limit
  end

  def self.current_days_total_transactions_amount(id)
    where('DATE(created_at) = DATE(?)', Time.zone.now).and(where(user_id: id))&.sum(:amount)
  end

  def set_payee
    @payee = User.find_payee(payee_info)

    raise ActiveRecord::RecordNotFound if @payee.blank?

    self.payee_id = @payee&.last&.id
  end
end