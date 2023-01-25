class AddContactNoToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :contact_no, :string, null: false
  end
end
