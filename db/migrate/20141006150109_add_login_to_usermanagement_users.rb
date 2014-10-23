class AddLoginToUsermanagementUsers < ActiveRecord::Migration
  def change
    add_column :usermanagement_users, :login, :string
    add_column :usermanagement_users, :firstname, :string
    add_column :usermanagement_users, :lastname, :string
    add_column :usermanagement_users, :email, :string
    add_column :usermanagement_users, :mobile, :string
    add_column :usermanagement_users, :language, :string

  end
end
