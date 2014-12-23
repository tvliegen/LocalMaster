load 'lib/tekcare_token_authentication.rb'

class Teknion::Base
  include ActiveModel::Model
  include Virtus.model
  include HTTParty

  def self.client
    @client ||= Faraday.new('http://api.corp.teknion.com/', ssl: {verify: false} ) do |faraday|
      faraday.use TekcareTokenAuthentication
      faraday.use Faraday::Request::UrlEncoded

      # Response
      faraday.response :json

      # Adapter
      faraday.use Faraday::Adapter::NetHttp 
    end
  end

end

