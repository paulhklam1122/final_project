class CreateFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :follows do |t|
      t.references :user, index: true, foreign_key: true
      t.references :goal, index: true, foreign_key: true

      t.timestamps
    end
  end
end
