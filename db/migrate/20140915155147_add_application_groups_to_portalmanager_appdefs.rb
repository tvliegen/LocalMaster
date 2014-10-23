class AddApplicationGroupsToPortalmanagerAppdefs < ActiveRecord::Migration
  def change
    add_column :portalmanager_appdefs, :application_groups, :string
  end
end
