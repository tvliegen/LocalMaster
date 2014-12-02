Faker::Config.locale = 'en-US'

# active claims
5.times.each do |p|
  claim = Claim.create!(
    after_hours_contact_name: "Bob Newhart",
    after_hours_contact_number: "555-555-5555",
    author: "Jim Jamie",
    claim_title: "New Claim",
    creation_date: rand(14).days.ago,
    dealer_contact_email: "me@me.com",
    dealer_contact_name: "Bob Newhart",
    dealer_contact_number:  "555-555-5555",
    dealer_code: "190017",
    dealer_name: "SCI Group",
    delivery_claim: "No",
    end_customer_name: "Big Important Company",
    installation_company: "Installer Joe",
    installation_in_progress: "No",
    installer_email: "installer@installer.com",
    installer_name: "Joe",
    installer_number: "555-555-5555",
    last_modified: Time.now,
    original_po: "1234567",
    original_po_rev: "1",
    original_sq: "1234567",
    product_in_storage: "No",
    project_name: "Day Work",
    replacement_cbd_name: "Joe",
    replacement_cbd_number: "555-555-5555",
    replacement_shipto_address: "10 Anywhere",
    replacement_shipto_city: "Somewhere",
    replacement_shipto_name: "Warehouse",
    replacement_shipto_state_prov: "ON",
    replacement_shipto_zip_pc: "L5P 2K5",
    scheduled_install_completion: rand(10).days.from_now,
    site_conditions: "accessible",
    site_visit_contact_email: "me@me.com",
    site_visit_contact_name: "joe",
    site_visit_contact_number: "555-555-5555",
    shipment_received_date: rand(5).days.ago,
    status: "in_progress",
    submission_date: rand(2).days.ago,
    tekcare_number: "2014-00000#{p+1}",
    universal: "1234567"
  )
  
  5.times.each do |i|
    claim.claim_issues.create!(
      cr: "J#{Faker::Number.number(5)}",
      item_code: "PM2436E",
      affected_quantity: "1",
      claim_description: "Someone broke it",
      issue_id: "2014-00001-00#{i+1}",
      item_description: "Its broke!",
      line_sequence: "#{i}",
      line_text: "Order notes from order",
      quantity: "1",
      reason_code: "Damaged",
      shipment_number: "1234567",
      status: "in_progress",
      tag: "2nd Floor Office"
    )
 
  3.times.each do
    claim_issue = claim.claim_issues.last
    claim_issue.clarifications.create!(
      author: Faker::Name.name,
      subject: Faker::Lorem.sentence(5),
      question: Faker::Lorem.sentence(8),
      answer: Faker::Lorem.sentence(8)     
    )
  end
  2.times.each do
    claim_issue = claim.claim_issues.last
    journal = claim_issue.journals.create!(
      author: Faker::Name.name,
      information_type: 'documentation',
      title: Faker::Lorem.sentence(3),
      information: Faker::Lorem.sentence(8)
    )
    journal.journal_attachments.create!(
      attachment: File.new("/home/royd/image.png")
    )
  end
  1.times.each do
    claim_issue = claim.claim_issues.last
    claim_issue.site_visits.create!(
      appointment_date: rand(14).days.ago,
      appointment_time: rand(5).hours.ago,
      author: Faker::Name.name,
      confirmed_by: Faker::Name.name,
      site_visit_name: Faker::Lorem.word
    )
  end
  1.times.each do
    claim_issue = claim.claim_issues.last
    action_plan = claim_issue.create_action_plan(
      action: 'replace',
      author: Faker::Name.name,
      text: Faker::Lorem.sentence(3)
    )
    3.times.each do
      action_plan.replacement_orders.create!(
        cr: Faker::Number.number(2),
        list_price: Faker::Commerce.price,
        product_code: Faker::Code.isbn,
        product_desc: Faker::Lorem.sentence(3),
        quantity: Faker::Number.number(1),
        status: 'Ordered'
      )
    end
  end
end
end
Portalmanager::Appdef.create("description"=>nil, "application_title"=>"Pre-Order", "application_url"=>"", "application_groups"=>"", "application_parent_menu"=>"Pre-Order")
Portalmanager::Appdef.create("description"=>nil, "application_title"=>"Order Submission & Validation", "application_url"=>"", "application_groups"=>".oe.", "application_parent_menu"=>"Pre-Order")
Portalmanager::Appdef.create("description"=>nil, "application_title"=>"Order Fulfillment", "application_url"=>"", "application_groups"=>"", "application_parent_menu"=>"Order Fulfillment")
Portalmanager::Appdef.create("description"=>nil, "application_title"=>"Order Status", "application_url"=>"", "application_groups"=>"status", "application_parent_menu"=>"Order Fulfillment")
Portalmanager::Appdef.create("description"=>nil, "application_title"=>"Post Order", "application_url"=>"", "application_groups"=>"", "application_parent_menu"=>"Post Order")
Portalmanager::Appdef.create("description"=>nil, "application_title"=>"Tekcare", "application_url"=>"/claims", "application_groups"=>"tekcare", "application_parent_menu"=>"Post Order")


