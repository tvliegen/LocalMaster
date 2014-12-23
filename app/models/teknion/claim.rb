class Teknion::Claim < Teknion::Base

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
  

  def self.all(status, dealer_code)
    response = client.get "tekcare/claims/#{status}/listbystatus", {dealer_code: dealer_code}
    return [] if response.body['claims'].nil?

    response.body['claims'].map {|item| new(item) }
  end

  def self.find(id, dealer_code)
    response = client.get "tekcare/claims/#{id}/claimdetail", {dealer_code: dealer_code}
    return if response.body.nil?

    new(response.body)
  end

end
