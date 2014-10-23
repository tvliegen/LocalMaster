class AddGroupToAppdefs < ActiveRecord::Migration
  def change
    add_column :appdefs, :group, :string
  end
end
