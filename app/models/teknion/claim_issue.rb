class Teknion::ClaimIssue
  include Her::Model

  belongs_to :claim, class_name: "Teknion::Claim"
  has_many :clarifications, class_name: "Teknion::Clarification"
end
