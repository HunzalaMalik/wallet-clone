# frozen_string_literal: true

module FundTransactionHelper
  def row_color(transaction, id)
    transaction.user_id.eql?(id) ? 'bg-red-400' : 'bg-green-400'
  end

  def sender_col(transaction, id)
    transaction.user_id.eql?(id) ?  "You (#{user_name(transaction.user_id)})" : user_name(transaction.user_id)
  end

  def receiver_col(transaction, id)
    transaction.user_id.eql?(id) ?  user_name(transaction.payee_id) : "You (#{user_name(transaction.payee_id)})"
  end
end
