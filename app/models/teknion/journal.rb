class Teknion::Journal
  #include Her::Model

  #belongs_to :claim_issue, class_name: "Teknion::ClaimIssue"
  #has_many :journal_attachments, class_name: "Teknion::JournalAttachment"

  #attributes :created_at, :author, :title, :information
  #validates :title, presence: true
  #validates :information, presence: true

  #accepts_nested_attributes_for :journal_attachments
end

