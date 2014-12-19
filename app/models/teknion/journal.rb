load 'lib/tekcare_token_authentication.rb'

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

  validates :subject, presence: true
  validates :content, presence: true
 
  def self.all(claim_id, dealer_code)
    journal_response = client.get "tekcare/issues/#{claim_id}/journallist", {dealer_code: dealer_code}
    
    unless journal_response.nil?
   #   journal_json = JSON.parse journal_response.body.gsub!(/\n/, '')

  journal_json = JSON.parse journal_response.body
  journal_json['journals'].map {|j| new(j) }
    end
  end

  def self.find(journal_id, claim_id, dealer_code)
    all(claim_id, dealer_code).find {|journal| journal.journal_id == journal_id }  
  end

  def self.client
    @client ||= Faraday.new('https://devapi.teknion.com/', ssl: {verify: false} ) do |faraday|
      faraday.use TekcareTokenAuthentication
      faraday.use Faraday::Request::UrlEncoded

      # Adapter
      faraday.use Faraday::Adapter::NetHttp
    end
  end
end

