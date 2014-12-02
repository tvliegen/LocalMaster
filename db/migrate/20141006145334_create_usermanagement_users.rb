class CreateUsermanagementUsers < ActiveRecord::Migration
  def change
    create_table :usermanagement_users do |t|

      t.timestamps
    end
  end
end
