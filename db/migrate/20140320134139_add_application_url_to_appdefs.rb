class AddApplicationUrlToAppdefs < ActiveRecord::Migration
  def change
    add_column :appdefs, :application_url, :string
  end
end
