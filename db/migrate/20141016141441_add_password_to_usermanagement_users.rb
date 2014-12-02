class AddPasswordToUsermanagementUsers < ActiveRecord::Migration
  def change
    add_column :usermanagement_users, :password, :string
    add_column :usermanagement_users, :password_confirm, :string
  end
end
