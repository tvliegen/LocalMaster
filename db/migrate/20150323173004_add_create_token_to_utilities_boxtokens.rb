class AddCreateTokenToUtilitiesBoxtokens < ActiveRecord::Migration
  def change
    add_column :utilities_boxtokens, :CreateToken, :Date
  end
end
