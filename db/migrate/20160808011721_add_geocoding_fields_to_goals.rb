class AddGeocodingFieldsToGoals < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :location, :string
    add_column :goals, :longitude, :float
    add_column :goals, :latitude, :float
  end
end
