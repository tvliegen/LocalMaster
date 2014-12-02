class CreateAppdefs < ActiveRecord::Migration
  def change
    create_table :appdefs do |t|
      t.timestamps
    end
  end
end

