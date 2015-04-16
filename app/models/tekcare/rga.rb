class Tekcare::RGA < Tekcare::Base

  attribute :rga_id, String
  attribute :issue_id, String
  attribute :incident_id, String
  attribute :po_number, String
  attribute :original_shipment_no, String
  attribute :original_invoice_no, String
  attribute :claimsrep_id, String
  attribute :rga_timestamp, Date

  def self.all(claim_issue_id, dealer_code)
    response = client.get "tekcare/issues/#{claim_issue_id}/rgalist", {dealer_code: dealer_code}
    unless response.body['rgas'].nil?
      response.body['rgas'].map {|item| new(item) }
    end
  end

  def self.find(id, claim_issue_id, dealer_code)
    all(claim_issue_id, dealer_code).find {|item| item.rga_id == id }
  end

end
