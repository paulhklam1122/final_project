class AddFacebookFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :facebook_token, :string
    add_column :users, :facebook_secret, :string
    add_column :users, :facebook_raw_data, :string
  end
end
