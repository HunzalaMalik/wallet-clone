module DashboardHelper
    def funds_recieved_count(id)
        FundTransaction.funds_recieved(id).count
    end

    def funds_sent_count(id)
        FundTransaction.funds_sent(id).count
    end

    def payee_list(id)
        Friendship.friends(id).last(3)
    end
end
