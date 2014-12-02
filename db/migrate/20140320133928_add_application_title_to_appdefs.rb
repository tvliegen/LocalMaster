class AddApplicationTitleToAppdefs < ActiveRecord::Migration
  def change
    add_column :appdefs, :application_title, :string
  end
end
