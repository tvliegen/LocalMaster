class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper :all
  before_action :checkLogin
  before_action :set_locale

private

  def tekcare_connection
    api_endpoint = ENV['API_ENDPOINT'] ? ENV['API_ENDPOINT'] : 'http://api.corp.teknion.com/'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: false} ) do |faraday|
      faraday.use TekcareTokenAuthentication
      faraday.use Faraday::Request::UrlEncoded

      # Response
      faraday.response :json

      # Adapter
      faraday.use Faraday::Adapter::NetHttp
    end

    logger.info conn.params
    return conn
  end
  
  private
  def set_locale
    I18n.locale = session[:Language] || I18n.default_locale
    session[:Language] = I18n.locale
  end

  def okta_connection
    api_endpoint = ENV['API_ENDPOINT'] ? ENV['API_ENDPOINT'] : 'http://api.corp.teknion.com/'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: false} ) do |faraday|
      faraday.use TekcareTokenAuthentication
      faraday.use Faraday::Request::UrlEncoded

      # Response
      faraday.response :json

      # Adapter
      faraday.use Faraday::Adapter::NetHttp
    end

    logger.info conn.params
    return conn
  end
  
  
  def checkLogin
    logger.info "Controller: #{controller_name}"

    logger.debug "Start: #{session[:valid_session]}"

    case session[:valid_session]
      when nil
	session[:valid_session]="New"
	session[:session_date]=DateTime.current - 1.minutes
	redirect_to "/"
	logger.info "New Session Created"
      when "Validated"
	logger.info "Session Exists: #{session[:valid_session]}"
	logger.info "Session Date: #{session[:session_date]}"
	if ((session[:session_date] + 2.hours) >= DateTime.current())
	  session[:session_date]=DateTime.current
	  session[:valid_session]="Validated"
	  logger.info "Session Renewed."
	else
	  logger.info "Session Expired"
	  session.clear
	  redirect_to "/"
	end
      when "New"
	logger.info "New Session Recognized"
      else
        session.clear
        logger.info "Session cleared"
    
   
      
  end

    
  end

end
