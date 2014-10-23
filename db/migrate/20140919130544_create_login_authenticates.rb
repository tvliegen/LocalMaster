class CreateLoginAuthenticates < ActiveRecord::Migration
  def change
    create_table :login_authenticates do |t|

      t.timestamps
    end
  end
end
