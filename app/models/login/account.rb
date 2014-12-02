require 'ruby-saml'

class Login::Account < ActiveRecord::Base
  def self.get_saml_settings
    # this is just for testing purposes. 
    
    # should retrieve SAML-settings based on subdomain, IP-address, NameID or similar
    settings = Onelogin::Saml::Settings.new
    
    settings.assertion_consumer_service_url   = "http://ec2-54-84-85-93.compute-1.amazonaws.com:3001/saml/consume"
    settings.issuer                           = "mysaasapp.com" # the name of your application
    #settings.idp_sso_target_url               = "https://teknion.okta.com/app/template_saml_2_0/kmkr7jhwWMQHVKZVFOGS/sso/saml"
    settings.idp_sso_target_url               = "https://teknion.oktapreview.com/app/template_saml_2_0/k2orwkn8VQAIPMNYNJDP/sso/saml"
    settings.idp_cert_fingerprint             = "12:80:C2:1B:FF:0A:2B:8F:AD:57:8E:1C:5A:7B:90:36:FC:0E:7F:D1"
    settings.name_identifier_format           = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
#settings.singlelogoutserviceurl = "http://ec2-54-84-85-93.compute-1.amazonaws.com:3001/saml/logout"
settings 
  end
end
