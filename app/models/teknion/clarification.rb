class Teknion::Clarification
  include Her::Model

  belongs_to :claim_issue, class_name: "Teknion::ClaimIssue"

  attributes :created_at, :author, :subject, :question, :answer
  validates :subject, presence: true
  validates :question, presence: true

  def status
    answer.empty? ? "Awaiting Response" : "Responded"
  end
end
