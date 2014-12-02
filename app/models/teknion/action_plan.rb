class Teknion::ActionPlan
  include Her::Model

  belongs_to :claim_issue, class_name: "Teknion::ClaimIssue"
  has_many :replacement_orders, class_name: "Teknion::ReplacementOrder"
end


