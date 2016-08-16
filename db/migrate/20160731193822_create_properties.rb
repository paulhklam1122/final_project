class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.float :value
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
