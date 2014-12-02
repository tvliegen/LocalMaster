class RemoveExternalauthToUsermanagementUsers < ActiveRecord::Migration
  def change
    remove_column :usermanagement_users, :externauthurl, :string
  end
end
