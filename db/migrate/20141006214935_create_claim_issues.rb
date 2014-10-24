class CreateClaimIssues < ActiveRecord::Migration
  def up
    create_table :claim_issues do |t|
      t.string :cr
      t.string :item_code
      t.string :affected_quantity
      t.string :claim_description
      t.string :issue_id
      t.string :item_description
      t.string :line_sequence
      t.string :line_text
      t.string :quantity
      t.string :reason_code
      t.string :shipment_number
      t.string :status
      t.string :tag

      # associations
      t.references :claim, index: true

      t.timestamps
    end
  end

  def down
    drop_table :claim_issues
  end
end
