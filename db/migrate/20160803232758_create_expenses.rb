class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.string :expense_name
      t.float :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
