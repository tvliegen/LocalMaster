class Teknion::BackCharge
  include ActiveModel::Model
  include Virtus.model
  include HTTParty

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

end
