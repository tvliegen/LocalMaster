class Teknion::Journal
  include ActiveModel::Model
  include Virtus.model
  include HTTParty

  attribute :journal_id, String
  attribute :issue_id, String
  attribute :subject, String
  attribute :content, String
  attribute :created_by, String
  attribute :timestamp, DateTime

  #has_many :journal_attachments, class_name: "Teknion::JournalAttachment"

  validates :subject, presence: true
  validates :content, presence: true

  #accepts_nested_attributes_for :journal_attachments
end

