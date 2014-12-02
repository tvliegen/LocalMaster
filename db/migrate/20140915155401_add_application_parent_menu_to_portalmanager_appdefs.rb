class AddApplicationParentMenuToPortalmanagerAppdefs < ActiveRecord::Migration
  def change
    add_column :portalmanager_appdefs, :application_parent_menu, :string
  end
end
