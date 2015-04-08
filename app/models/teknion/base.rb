load 'lib/tekcare_token_authentication.rb'

class Teknion::Base
  include ActiveModel::Model
  include Virtus.model
  include HTTParty

  def self.client
    api_endpoint = ENV['API_ENDPOINT'] ? ENV['API_ENDPOINT'] : 'http://api.corp.teknion.com/'
    @client ||= Faraday.new(api_endpoint, ssl: {verify: false} ) do |faraday|
      faraday.use TekcareTokenAuthentication
      faraday.use Faraday::Request::UrlEncoded
      faraday.response :logger 

      # Response
      faraday.response :json

      # Adapter
      faraday.use Faraday::Adapter::NetHttp
    end
  end

end

