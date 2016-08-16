class CreateCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_cards do |t|
      t.string :card_name
      t.float :monthly_balance
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
