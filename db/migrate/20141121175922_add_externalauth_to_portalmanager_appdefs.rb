class AddExternalauthToPortalmanagerAppdefs < ActiveRecord::Migration
  def change
    add_column :portalmanager_appdefs, :externauthurl, :string
  end
end
