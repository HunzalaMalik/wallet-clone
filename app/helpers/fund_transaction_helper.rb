module FundTransactionHelper
    def row_color(transaction, id)
        transaction.user_id.eql?(id) ? "bg-red-400" : "bg-green-400"
    end
end
