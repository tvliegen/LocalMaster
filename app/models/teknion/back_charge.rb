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

  def self.all(claim_issue_id, dealer_code)
    response = client.get "tekcare/issues/#{claim_issue_id}/backchargelist", {dealer_code: dealer_code}
    return [] if response.body['backcharges'].nil?
    response.body['backcharges'].map {|item| new(item) }
  end

  def self.find(id, claim_issue_id, dealer_code)
    all(claim_issue_id, dealer_code).find {|item| item.bc_id == id }
  end

end
