# frozen_string_literal: true

module DashboardHelper
  def funds_recieved_count(id)
    FundTransaction.where(payee_id: id).count
  end

  def funds_sent_count(id)
    FundTransaction.where(user_id: id).count
  end

  def payee_list(id)
    Friendship.friends(id).last(3)
  end
end
