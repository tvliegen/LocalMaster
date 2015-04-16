class AddInternalInstallerCertifications < ActiveRecord::Migration
  def change
        add_column :internal_installer_certifications, :companyid, :integer
    add_column :internal_installer_certifications, :companyname, :string
    add_column :internal_installer_certifications, :companyaddress, :string
    add_column :internal_installer_certifications, :companycity, :string
    add_column :internal_installer_certifications, :companyprovstate, :string
    add_column :internal_installer_certifications, :companycountry, :string
    add_column :internal_installer_certifications, :companypostalzip, :string
    add_column :internal_installer_certifications, :companycontactname, :string
    add_column :internal_installer_certifications, :companycontactnumber, :string
    add_column :internal_installer_certifications, :companycontactemail, :string
    add_column :internal_installer_certifications, :companydealers, :string
    add_column :internal_installer_certifications, :companyprojects, :string
    add_column :internal_installer_certifications, :companycomments, :string
  end
end
