class Teknion::RGA
  include ActiveModel::Model
  include Virtus.model
  include HTTParty

  attribute :rga_id, String
  attribute :issue_id, String
  attribute :incident_id, String
  attribute :po_number, String
  attribute :original_shipment_no, String
  attribute :original_invoice_no, String
  attribute :claimsrep_id, String
  attribute :rga_timestamp, String
end
