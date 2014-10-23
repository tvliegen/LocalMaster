class AddUsernameToLoginAuthenticate < ActiveRecord::Migration
  def change
    add_column :login_authenticates, :username, :string
  end
end
