class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.string :goal_name
      t.float :amount
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
