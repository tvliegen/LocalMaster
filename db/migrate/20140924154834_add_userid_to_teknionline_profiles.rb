class AddUseridToTeknionlineProfiles < ActiveRecord::Migration
  def change
    add_column :teknionline_profiles, :userid, :string
    add_column :teknionline_profiles, :firstname, :string
    add_column :teknionline_profiles, :lastname, :string
    add_column :teknionline_profiles, :email, :string
    add_column :teknionline_profiles, :login, :string
    add_column :teknionline_profiles, :language, :string
  end
end
