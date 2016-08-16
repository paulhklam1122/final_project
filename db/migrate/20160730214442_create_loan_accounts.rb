class CreateLoanAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :loan_accounts do |t|
      t.string :loan_name
      t.float :balance
      t.float :monthly_payment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
