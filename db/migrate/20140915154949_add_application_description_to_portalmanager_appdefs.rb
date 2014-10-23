class AddApplicationDescriptionToPortalmanagerAppdefs < ActiveRecord::Migration
  def change
    add_column :portalmanager_appdefs, :description, :string
  end
end
