class AddApplicationTitleToPortalmanagerAppdefs < ActiveRecord::Migration
  def change
    add_column :portalmanager_appdefs, :application_title, :string
  end
end
