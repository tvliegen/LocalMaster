class AddApplicationUrlToPortalmanagerAppdefs < ActiveRecord::Migration
  def change
    add_column :portalmanager_appdefs, :application_url, :string
  end
end
