load 'lib/tekcare_token_authentication.rb'

class Teknion::Journal < Teknion::Base

  attribute :journal_id, String
  attribute :issue_id, String
  attribute :subject, String
  attribute :content, String
  attribute :created_by, String
  attribute :timestamp, DateTime

  validates :subject, presence: true
  validates :content, presence: true

  def self.all(claim_issue_id, dealer_code)
    journal_response = client.get "tekcare/issues/#{claim_issue_id}/journallist", {dealer_code: dealer_code}

    journal_json = JSON.parse journal_response.body
    unless journal_json['journals'].nil?
      journal_json['journals'].map {|j| new(j) }
    end
  end

  def self.find(journal_id, claim_id, dealer_code)
    all(claim_id, dealer_code).find {|journal| journal.journal_id == journal_id }
  end

  # override the base class as we'll parse the json manually
  def self.client
    api_endpoint = ENV['API_ENDPOINT'] ? ENV['API_ENDPOINT'] : 'http://api.corp.teknion.com/'
    @client ||= Faraday.new(api_endpoint, ssl: {verify: false} ) do |faraday|
      faraday.use TekcareTokenAuthentication
      faraday.use Faraday::Request::UrlEncoded

      # Adapter
      faraday.use Faraday::Adapter::NetHttp
    end
  end

end
