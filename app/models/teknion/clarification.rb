class Teknion::Clarification
  include ActiveModel::Model
  include Virtus.model
  include HTTParty

  attribute :issue_id, String
  attribute :clarification_id, String
  attribute :clarification_type, String
  attribute :response_to_id, String
  attribute :subject, String
  attribute :content, String
  attribute :sent_by, String
  attribute :sent_to, String
  attribute :timestamp, DateTime

  #attributes :created_at, :author, :subject, :question, :answer
  #validates :subject, presence: true
  #validates :question, presence: true

  def status
    response_to_id.empty? ? "Awaiting Response" : "Responded"
  end
end
