class CreateClaims < ActiveRecord::Migration
  def up
    create_table :claims do |t|
      t.string    :after_hours_contact_name
      t.string    :after_hours_contact_number
      t.string    :author
      t.string    :claim_title
      t.datetime  :creation_date
      t.string    :dealer_contact_email
      t.string    :dealer_contact_name
      t.string    :dealer_contact_number
      t.string    :dealer_code
      t.string    :dealer_name
      t.string    :delivery_claim
      t.string    :end_customer_name
      t.string    :installation_company
      t.string    :installation_in_progress
      t.string    :installer_email
      t.string    :installer_name
      t.string    :installer_number
      t.datetime  :last_modified
      t.string    :original_po
      t.string    :original_po_rev
      t.string    :original_sq
      t.string    :product_in_storage
      t.string    :project_name
      t.string    :replacement_cbd_name
      t.string    :replacement_cbd_number
      t.string    :replacement_shipto_address
      t.string    :replacement_shipto_city
      t.string    :replacement_shipto_name
      t.string    :replacement_shipto_state_prov
      t.string    :replacement_shipto_zip_pc
      t.string    :scheduled_install_completion
      t.string    :site_conditions
      t.string    :site_visit_contact_email
      t.string    :site_visit_contact_name
      t.string    :site_visit_contact_number
      t.datetime  :shipment_received_date
      t.string    :status
      t.datetime  :submission_date
      t.string    :tekcare_number
      t.string    :universal

      t.timestamps
    end
  end

  def down
    drop_table :claims
  end
end
