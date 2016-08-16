class CreateBankAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_accounts do |t|
      t.string :bank_name
      t.string :account_type
      t.float :account_balance
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
