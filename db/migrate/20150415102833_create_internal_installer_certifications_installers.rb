class CreateInternalInstallerCertificationsInstallers < ActiveRecord::Migration
  def change
    create_table :internal_installer_certifications_installers do |t|

      t.timestamps
    end
  end
end
