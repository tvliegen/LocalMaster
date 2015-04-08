class Teknion::BackCharge < Teknion::Base

  attribute :bc_id, String
  attribute :create_date, String
  attribute :document_date, String
  attribute :bc_type_code, String
  attribute :currency, String
  attribute :estimated_from, String
  attribute :cancelled, String
  attribute :submitted, String
  attribute :imaged, String
  attribute :approved, String
  attribute :sent_to_finance, String
  attribute :finance_accepted, String
  attribute :issue_cheque, String
  attribute :issue_credit, String
  attribute :declined, String
  attribute :procesed, String
  attribute :bc_status, String
  attribute :finance_declined, String
  attribute :estimate_amount, String
  attribute :authorized_amount, String
  attribute :description, String
  attribute :facilty_approval_required, String
  attribute :facilty_approved, String
  attribute :facility_declined, String
  attribute :bc_origin, String
  attribute :bc_copied_from_bcid, String
  attribute :bc_header, Hash
  attribute :bc_actual, Hash
  attribute :bc_status, Hash
  attribute :bc_shared_costs, Hash
  attribute :bc_approvers, Hash
  attribute :bc_cost_splits, Array
  attribute :bc_deductions, Array
  attribute :bc_facility_approval, Array
  attribute :bc_facility_approval_entries, Array

  attribute :issue_id, String
  attribute :initial, Hash
  attribute :shared_costs, Hash

  def summary
    "Summary: "
  end

  def save
    body = {
      issue_id: self.issue_id,
      intial: self.initial,
      shared_costs: self.shared_costs
    }.to_json
    return body

    # TODO: uncomment when API endpoint is operational -CS
    #response = client.post do |req|
      #req.url "tekcare/backcharges?dealer_code=#{dealer_code}"
      #req.headers['Content-Type'] = 'application/json'
      #req.body = body
    #end

    #if journal_response.status == 201
      #return true
    #else
      #return false
    #end
  end

  def self.all(claim_issue_id, dealer_code)
    response = client.get "tekcare/issues/#{claim_issue_id}/backchargelist", {dealer_code: dealer_code}
    return [] if response.body['backcharges'].nil?
    response.body['backcharges'].map {|item| new(item) }
  end

  def self.find(id, dealer_code)
    response = client.get "tekcare/backcharges/#{id}/backchargedetail", {dealer_code: dealer_code}
    return nil if response.body.nil?

    new(response.body)
  end

end
