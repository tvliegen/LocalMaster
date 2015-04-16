class AddInternalInstallerCertificationsInstallers < ActiveRecord::Migration
  def change    
    add_column :internal_installer_certifications_installers, :companyid, :integer
    add_column :internal_installer_certifications_installers, :installerid, :integer
    add_column :internal_installer_certifications_installers, :installername, :string
    add_column :internal_installer_certifications_installers, :installercontactnumber, :string
    add_column :internal_installer_certifications_installers, :installercontactemail, :string
    
  end
end
