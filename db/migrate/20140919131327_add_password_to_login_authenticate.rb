class AddPasswordToLoginAuthenticate < ActiveRecord::Migration
  def change
    add_column :login_authenticates, :password, :string
  end
end
