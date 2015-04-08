class AddAccessTokenToUtilitiesBoxtokens < ActiveRecord::Migration
  def change
    add_column :utilities_boxtokens, :AccessToken, :string
  end
end
