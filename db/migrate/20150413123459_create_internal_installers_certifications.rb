class CreateInternalInstallersCertifications < ActiveRecord::Migration
  def change
    create_table :internal_installers_certifications do |t|

      t.timestamps
    end
  end
end
