class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :tekcare_number
      t.string :title
      t.string :project
      t.string :created_by
      t.string :status

      t.timestamps
    end
  end
end
