class AddParentMenuToAppdefs < ActiveRecord::Migration
  def change
    add_column :appdefs, :parent_menu_item, :string
  end
end
