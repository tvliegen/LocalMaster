class Teknion::Journal
  include ActiveModel::Model
  include Virtus.model
  include HTTParty

  attribute :journal_id, String
  attribute :issue_id, String
  attribute :subject, String
  attribute :content, String
  attribute :created_by, String
  attribute :timestamp, String

  #has_many :journal_attachments, class_name: "Teknion::JournalAttachment"

  #attributes :created_at, :author, :title, :information
  #validates :title, presence: true
  #validates :information, presence: true

  #accepts_nested_attributes_for :journal_attachments
end

