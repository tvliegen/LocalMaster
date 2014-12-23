class Teknion::ClaimIssue < Teknion::Base

  attribute :actionplan_id, String
  attribute :issue_id, String
  attribute :incident_id, String
  attribute :reason_teknion, String
  attribute :reason_facility, String
  attribute :response_code, String
  attribute :comment, String
  attribute :actionplan_timestamp, String
  attribute :issue_id, String
  attribute :incident_id, String
  attribute :issue_status, String
  attribute :issue_closed, String
  attribute :line_sequence, String
  attribute :item_code, String
  attribute :item_description, String
  attribute :order_qty, String
  attribute :affected_qty, String
  attribute :facility_code, String
  attribute :facility_accept, String
  attribute :images, Array
  attribute :clarifications, Array[Teknion::Clarification]
  attribute :journals, Array[Teknion::Journal]
  attribute :replaced_products, Array[Teknion::ReplacementOrder]
  attribute :rgas, Array[Teknion::RGA]
  attribute :back_charges, Array[Teknion::BackCharge]
  attribute :original_cr_number, String
  attribute :original_line_notes, String
  attribute :original_line_tags, String
  attribute :problem_category, String
  attribute :problem_description, String
end
