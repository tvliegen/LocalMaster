class CreateTeknionlineProfiles < ActiveRecord::Migration
  def change
    create_table :teknionline_profiles do |t|

      t.timestamps
    end
  end
end
