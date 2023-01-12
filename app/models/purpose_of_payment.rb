# frozen_string_literal: true

class PurposeOfPayment < ApplicationRecord
  has_many :fund_transactions, dependent: :nullify

  validates :name, presence: true, allow_blank: false,
                   format: { with: /\A[^0-9`!@#$%\^&*+_=]+\z/ }
end
