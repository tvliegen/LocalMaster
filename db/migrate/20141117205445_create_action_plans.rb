class CreateActionPlans < ActiveRecord::Migration
  def change
    create_table :action_plans do |t|
      t.references :claim_issue, index: true
      t.string :action
      t.string :author
      t.string :text

      t.timestamps
    end
  end
end
