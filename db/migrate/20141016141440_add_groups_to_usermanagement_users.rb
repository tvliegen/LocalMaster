class AddGroupsToUsermanagementUsers < ActiveRecord::Migration
  def change
    add_column :usermanagement_users, :groups, :string
  end
end
