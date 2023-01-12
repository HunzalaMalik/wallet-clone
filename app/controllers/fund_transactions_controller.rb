# frozen_string_literal: true

class FundTransactionsController < ApplicationController
  def index
    @fund_transactions = FundTransaction.transactions(current_user.id)
  end

  def new
    @fund_transaction = current_user.fund_transaction.build
  end

  def create
    @fund_transaction = current_user.fund_transaction.build(fund_transaction_params)

    if @fund_transaction.save
      flash[:notice] = 'Transaction has been successfully completed'
    else
      flash[:error] = @fund_transaction.errors.full_messages.to_sentence
    end
    redirect_to request.referer
  end

  private

  def fund_transaction_params
    params.require(:fund_transaction).permit(:payee_id, :purpose_of_payment_id, :amount)
  end
end
