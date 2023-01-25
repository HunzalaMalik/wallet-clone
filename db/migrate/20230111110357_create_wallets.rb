class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.integer :amount, default: 0, null: false
      t.belongs_to :user, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
