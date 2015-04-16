class CreateInternalInstallerCertifications < ActiveRecord::Migration
  def change
    create_table :internal_installer_certifications do |t|

      t.timestamps
    end
  end
end
