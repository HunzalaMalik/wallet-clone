class CreateFundTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :fund_transactions do |t|
      t.belongs_to :user, null: false
      t.belongs_to :payee, null: false, foreign_key: {to_table: :users}
      t.belongs_to :purpose_of_payment, null: false, foreign_key: true
      t.integer :amount, default: 0, null: false

      t.timestamps
    end
  end
end
