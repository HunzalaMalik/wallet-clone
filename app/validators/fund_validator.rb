# frozen_string_literal: true

class FundValidator < ActiveModel::Validator
  def validate(record)
    return if record.user.has_role?(:admin)

    if record.amount > record.user.wallet.amount
      record.errors.add(:base, 'Balance is not enough')
    elsif record.user.eql?(record.payee)
      record.errors.add(:base, "Sender can't be payee")
    end
  end
end
