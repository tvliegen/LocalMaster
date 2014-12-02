class CreateJournal < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :author
      t.string :information_type
      t.string :title
      t.text :information
      t.references :claim_issue, index: true

      t.timestamps
    end
  end
end
