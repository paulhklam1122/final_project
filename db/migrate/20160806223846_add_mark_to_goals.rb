class AddMarkToGoals < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :mark, :string, :default => "Not Achieved"
  end
end
