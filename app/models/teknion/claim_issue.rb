class Teknion::ClaimIssue
  include Her::Model

  belongs_to :claim, class_name: "Teknion::Claim"
  has_many :clarifications, class_name: "Teknion::Clarification"
  has_many :journals, class_name: "Teknion::Journal"
  has_many :site_visits, class_name: "Teknion::SiteVisit"
  has_one :action_plan, class_name: "Teknion::ActionPlan"
end
