class AddLanguageToLoginAuthenticate < ActiveRecord::Migration
  def change
    add_column :login_authenticates, :language, :string
  end
end
