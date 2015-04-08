class Idp::Base
  include ActiveModel::Model
  include Virtus.model
  include HTTParty

  def self.client
    api_endpoint = 'https://teknion.oktapreview.com/'
    @client ||= Faraday.new(api_endpoint, ssl: {verify: true} ) do |faraday|
      faraday.use Faraday::Request::UrlEncoded
      faraday.headers['Authorization']='SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7'
      faraday.headers['Content-Type']='application/json'
      faraday.headers['Accept']='application/json'
      faraday.response :logger 
      faraday.use Faraday::Adapter::NetHttp
    end
  end

end