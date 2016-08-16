class AddGoogleFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :google_token, :string
    add_column :users, :google_secret, :string
    add_column :users, :google_raw_data, :string
  end
end
