# frozen_string_literal: true

class FundsTransactionService
  def initialize(resource)
    @resource = resource
  end

  def add_payment
    @resource.payee.wallet.update!(amount: @resource.payee.wallet.amount + @resource.amount)
  end

  def subtract_payment
    return true if @resource.user.has_role?(:admin)

    @resource.user.wallet.update!(amount: @resource.user.wallet.amount - @resource.amount)
  end

  def transaction
    FundTransaction.transaction do
      raise ActiveRecord::Rollback unless subtract_payment

      add_payment
    end
  rescue ActiveRecord::Rollback
    @resource.errors.add(:base, 'Transaction was not successful')
  end

  def check_limit
    binding.break
    unless FundTransaction.current_day_transactions_amount(@resource.user_id) > 25_000 &&
           @resource.user.has_role?(:user)
      return
    end

    @resource.user.wallet.update!(amount: @resource.user.wallet.amount - 200)
    @resource.amount = @resource.amount + 200
  end
end
