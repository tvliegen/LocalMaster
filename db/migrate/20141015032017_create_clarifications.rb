class CreateClarifications < ActiveRecord::Migration
  def change
    create_table :clarifications do |t|
      t.string :author
      t.string :text
      t.references :claim_issue, index: true

      t.timestamps
    end
  end
end
