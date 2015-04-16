class Tekcare::Clarification < Tekcare::Base

  attribute :issue_id, String
  attribute :clarification_id, String
  attribute :clarification_type, String
  attribute :type, String
  attribute :response_to_id, String
  attribute :subject, String
  attribute :content, String
  attribute :sent_by, String
  attribute :sent_to, String
  attribute :timestamp, DateTime
  attribute :status, String
  #attributes :created_at, :author, :subject, :question, :answer
  #validates :subject, presence: true
  #validates :question, presence: true

  def self.all(claim_issue_id, dealer_code)
    response = client.get "tekcare/issues/#{claim_issue_id}/clarificationlist", {dealer_code: dealer_code}
    return [] if response.body['clarifications'].nil?

    response.body['clarifications'].map {|item| new(item) }
    

  end

  def self.find(id, claim_issue_id, dealer_code)
    all(claim_issue_id, dealer_code).find {|cl| cl.clarification_id == id }
  end

  
end
