class AddInternalInstallersCertificationsInstallersCerts < ActiveRecord::Migration
 
  def change
    
    add_column :internal_installers_certifications_installers_certs, :companyid, :integer
    add_column :internal_installers_certifications_installers_certs, :installerid, :integer
    add_column :internal_installers_certifications_installers_certs, :certid, :integer
    add_column :internal_installers_certifications_installers_certs, :certname, :string
    add_column :internal_installers_certifications_installers_certs, :certtrainingdate, :date
    add_column :internal_installers_certifications_installers_certs, :certexpirydate, :date
    add_column :internal_installers_certifications_installers_certs, :certauditcomplete, :boolean
    add_column :internal_installers_certifications_installers_certs, :certnumber, :string
  end
end
