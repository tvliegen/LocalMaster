class CreateSiteVisits < ActiveRecord::Migration
  def change
    create_table :site_visits do |t|
      t.references :claim_issue, index: true
      t.datetime :appointment_date
      t.datetime :appointment_time
      t.string :author
      t.string :confirmed_by
      t.string :site_visit_name

      t.timestamps
    end
  end
end
