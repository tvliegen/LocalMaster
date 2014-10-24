class Teknion::Clarification
  include Her::Model

  belongs_to :claim_issue, class_name: "Teknion::ClaimIssue"
end
