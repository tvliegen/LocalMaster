class Tekcare::ClaimIssue < Tekcare::Base

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
  attribute :original_cr_number, String
  attribute :original_line_notes, String
  attribute :original_line_tags, String
  attribute :problem_category, String
  attribute :problem_description, String
  attribute :clarifications, Array[Tekcare::Clarification]
  attribute :journals, Array[Teknion::Journal]
  attribute :replaced_products, Array[Tekcare::ReplacementOrder]
  attribute :rgas, Array[Tekcare::RGA]
  attribute :back_charges, Array[Tekcare::BackCharge]
  attribute :site_visits, Array[Tekcare::SiteVisit]
  attribute :original_shipment, String
  attribute :issue_status_desc, String
  attribute :product_in_storage, String
  attribute :action_plan, Array[Tekcare::ActionPlan]
  attribute :attachments, Array



end
