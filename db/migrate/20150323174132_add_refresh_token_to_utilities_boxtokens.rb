class AddRefreshTokenToUtilitiesBoxtokens < ActiveRecord::Migration
  def change
    add_column :utilities_boxtokens, :RefreshToken, :string
  end
end
