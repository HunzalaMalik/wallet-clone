class CreatePurposeOfPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :purpose_of_payments do |t|
      t.string :purpose, null: false

      t.timestamps
    end
  end
end
