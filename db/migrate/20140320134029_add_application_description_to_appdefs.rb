class AddApplicationDescriptionToAppdefs < ActiveRecord::Migration
  def change
    add_column :appdefs, :application_description, :text
  end
end
