class CreateInternalInstallerCertficationCerts < ActiveRecord::Migration
  def change
    create_table :internal_installer_certfication_certs do |t|

      t.timestamps
    end
  end
end
