class AddExternalauthToUsermanagementUsers < ActiveRecord::Migration
  def change
    add_column :usermanagement_users, :externauthurl, :string
  end
end
