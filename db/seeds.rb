Faker::Config.locale = 'en-US'

# active claims
5.times.each do
  claim = Claim.create!(
    after_hours_contact_name: Faker::Name.name,
    after_hours_contact_number: Faker::PhoneNumber.phone_number,
    author: Faker::Name.name,
    claim_title: Faker::Lorem.sentence(3),
    creation_date: rand(14).days.ago,
    dealer_contact_email: Faker::Internet.email,
    dealer_contact_name: Faker::Name.name,
    dealer_contact_number: Faker::PhoneNumber.phone_number,
    dealer_code: Faker::Number.number(8),
    dealer_name: Faker::Company.name,
    delivery_claim: Faker::Lorem.word,
    end_customer_name: Faker::Name.name,
    installation_company: Faker::Company.name,
    installation_in_progress: "false",
    installer_email: Faker::Internet.email,
    installer_name: Faker::Name.name,
    installer_number: Faker::PhoneNumber.phone_number,
    last_modified: Time.now,
    original_po: Faker::Number.number(5),
    original_po_rev: Faker::Number.number(1),
    original_sq: Faker::Number.number(10),
    product_in_storage: "false",
    project_name: Faker::Lorem.sentence(2),
    replacement_cbd_name: Faker::Name.name,
    replacement_cbd_number: Faker::PhoneNumber.phone_number,
    replacement_shipto_address: Faker::Address.street_address,
    replacement_shipto_city: Faker::Address.city,
    replacement_shipto_name: Faker::Name.name,
    replacement_shipto_state_prov: Faker::Address.state_abbr,
    replacement_shipto_zip_pc: Faker::Address.zip,
    scheduled_install_completion: rand(10).days.from_now,
    site_conditions: "accessible",
    site_visit_contact_email: Faker::Internet.email,
    site_visit_contact_name: Faker::Name.name,
    site_visit_contact_number: Faker::PhoneNumber.phone_number,
    shipment_received_date: rand(5).days.ago,
    status: "in_progress",
    submission_date: rand(2).days.ago,
    tekcare_number: Faker::Number.number(10),
    universal: "true"
  )
  5.times.each do
    claim.claim_issues.create!(
      cr: "J#{Faker::Number.number(5)}",
      item_code: "AB#{Faker::Number.number(7)}",
      affected_quantity: Faker::Number.number(1),
      claim_description: Faker::Lorem.sentence(3),
      issue_id: Faker::Number.number(5),
      item_description: Faker::Lorem.sentence(3),
      line_sequence: Faker::Number.number(5),
      line_text: Faker::Lorem.sentence(3),
      quantity: Faker::Number.number(1),
      reason_code: Faker::Lorem.sentence(2),
      shipment_number: Faker::Number.number(8),
      status: "in_progress",
      tag: Faker::Lorem.sentence(2)
    )
  end
  3.times.each do
    claim.claim_issues.first.clarifications.create!(
      author: Faker::Name.name,
      text: Faker::Lorem.sentence(5)
    )
  end
end

# closed claims
3.times.each do
  claim = Claim.create!(
    after_hours_contact_name: Faker::Name.name,
    after_hours_contact_number: Faker::PhoneNumber.phone_number,
    author: Faker::Name.name,
    claim_title: Faker::Lorem.sentence(3),
    creation_date: rand(14).days.ago,
    dealer_contact_email: Faker::Internet.email,
    dealer_contact_name: Faker::Name.name,
    dealer_contact_number: Faker::PhoneNumber.phone_number,
    dealer_code: Faker::Number.number(8),
    dealer_name: Faker::Company.name,
    delivery_claim: Faker::Lorem.word,
    end_customer_name: Faker::Name.name,
    installation_company: Faker::Company.name,
    installation_in_progress: "false",
    installer_email: Faker::Internet.email,
    installer_name: Faker::Name.name,
    installer_number: Faker::PhoneNumber.phone_number,
    last_modified: Time.now,
    original_po: Faker::Number.number(5),
    original_po_rev: Faker::Number.number(1),
    original_sq: Faker::Number.number(10),
    product_in_storage: "false",
    project_name: Faker::Lorem.sentence(2),
    replacement_cbd_name: Faker::Name.name,
    replacement_cbd_number: Faker::PhoneNumber.phone_number,
    replacement_shipto_address: Faker::Address.street_address,
    replacement_shipto_city: Faker::Address.city,
    replacement_shipto_name: Faker::Name.name,
    replacement_shipto_state_prov: Faker::Address.state_abbr,
    replacement_shipto_zip_pc: Faker::Address.zip,
    scheduled_install_completion: rand(10).days.from_now,
    site_conditions: "accessible",
    site_visit_contact_email: Faker::Internet.email,
    site_visit_contact_name: Faker::Name.name,
    site_visit_contact_number: Faker::PhoneNumber.phone_number,
    shipment_received_date: rand(5).days.ago,
    status: "closed",
    submission_date: rand(2).days.ago,
    tekcare_number: Faker::Number.number(10),
    universal: "true"
  )
  5.times.each do
    claim.claim_issues.create!(
      cr: "J#{Faker::Number.number(5)}",
      item_code: "AB#{Faker::Number.number(7)}",
      affected_quantity: Faker::Number.number(1),
      claim_description: Faker::Lorem.sentence(3),
      issue_id: Faker::Number.number(5),
      item_description: Faker::Lorem.sentence(3),
      line_sequence: Faker::Number.number(5),
      line_text: Faker::Lorem.sentence(3),
      quantity: Faker::Number.number(1),
      reason_code: Faker::Lorem.sentence(2),
      shipment_number: Faker::Number.number(8),
      status: "closed",
      tag: Faker::Lorem.sentence(2)
    )
  end
end

