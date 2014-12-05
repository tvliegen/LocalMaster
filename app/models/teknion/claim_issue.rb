class Teknion::ClaimIssue
  include ActiveModel::Model
  include Virtus.model
  include HTTParty

  attribute :issue_id, String
  attribute :issue_status, String
  attribute :issue_closed, String
  attribute :line_sequence, String
  attribute :item_code, String
  attribute :item_description, String
  attribute :quantity, String
  attribute :affected_quantity, String
  attribute :facility_code, String
  attribute :facility_accept, String
  attribute :images, Array

  #has_many :clarifications, class_name: "Teknion::Clarification"
  #has_many :journals, class_name: "Teknion::Journal"
  #has_many :site_visits, class_name: "Teknion::SiteVisit"
  #has_one :action_plan, class_name: "Teknion::ActionPlan"
end
