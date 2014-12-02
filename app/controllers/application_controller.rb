class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper :all	
 # before_action :checkLogin
   

     
     
   def checkLogin
     logger.info "Controller: #{controller_name}"
      logger.debug "Start: #{session[:valid_session]}"
     
      
      case session[:valid_session]
	
      when nil
	session[:valid_session]="New"
	session[:session_date]=DateTime.current - 1.minutes
	redirect_to "/"
      when "Validated"
       
	 logger.info "Session Exists: #{session[:valid_session]}"
	 logger.info "Session Date: #{session[:session_date]}"
	    if ((session[:session_date] + 1.minutes) >= DateTime.current())
	      session[:session_date]=DateTime.current
	      session[:valid_session]="Validated"
	    else
	 
	      session.clear
	      logger.info "Session cleared"
	      session[:valid_session]=nil
	    end 
  
	   
     end
  
   end
   
    	     		 
    	     	    
 
end
