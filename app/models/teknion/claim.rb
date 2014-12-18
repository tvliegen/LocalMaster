class Teknion::Claim
  include ActiveModel::Model
  include Virtus.model
  include HTTParty

  # used for claim_details call
  attribute :header, Hash
  attribute :customer, Hash
  attribute :ship_replacement_to, Hash
  attribute :claim_issues, Array[Teknion::ClaimIssue]

  # used for index call
  attribute :incident_id, String
  attribute :claim_description, String
  attribute :dealer_name, String
  attribute :contact_name, String
  attribute :shipto_name, String
  attribute :incident_date, String
  attribute :incident_time, String
  attribute :incident_status, String
  attribute :tekcare_number, String
end
