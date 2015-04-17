
class Login::AuthenticatesController < ApplicationController
  layout false
  
  def login
    @login_authenticate = Login::Authenticate.new
    @errCode=nil
  end


  def idpLogin
  	  @login_authenticate = Login::Authenticate.new(login_authenticate_params)

	loginResults=Idp::User.validate_user(@login_authenticate.username, @login_authenticate.password)

if loginResults['errorCode'].nil?

	session.clear
	session[:session_date]=DateTime.current
	session[:valid_session]="Validated"
	idp_id=loginResults["userId"]
	session[:session_cookie]=loginResults["cookieTokenUrl"]
	
	session[:idp_session_id]=loginResults["id"]
	session[:idp_id]=idp_id
	session[:username]=@login_authenticate.username
	
	set_session

	
else   
#render inline: "hello"
	respond_to do |format|
	  format.html { redirect_to "/" }
   #    format.json { render json: @login_authenticate.errors, status: :unprocessable_entity }
end

      end



end

def login_fotonotes
  @fn=FotonotesLogin.new
  
  session[:fntoken]=@fn.login(session[:username],session[:DealerCode])
 redirect_to params["redirect"]
 
end
 
def set_session
	@idp=IdpLogin.new
	idp_id=session[:idp_id]
	@user_profile_raw=Idp::User.get_profile(idp_id)
	session[:FirstName] =@user_profile_raw["profile"]["firstName"]
	session[:LastName] = @user_profile_raw["profile"]["lastName"]
	session[:Language] = @user_profile_raw["profile"]["language"]
	if @login_authenticate.language == 'en'
	  session[:Language] = @login_authenticate.language
	  set_language_english_path
	elsif @login_authenticate.language == 'fr'
	  session[:Language] = @login_authenticate.language
	  set_language_french_path
	end
	
	session[:Groups]=@idp.getGroups(idp_id,'names').select {|g| g.include? 'dealer'}
	session[:DealerCode]=set_default_dealercode
	
	respond_to do |format|
      
      	     format.html { redirect_to "/login/authenticates/loginfn?redirect=/claims" }
	end
end

 def validate_session
 @idp=IdpLogin.new
	@errCode = nil	 
	session_result=@idp.validate_session(session[:idp_session_id])
	redirect_to "/"
 end
 
 def logout
 	session.clear

  	  redirect_to "/"	 
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_login_authenticate
      @login_authenticate = Login::Authenticate.find(params[:id])
    end
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def login_authenticate_params

      params.require(:login_authenticate).permit(:username, :password, :language)
    end

    def set_default_dealercode
    	    
    	    groups=session[:Groups]
    	    
    	  
    	    	    dealerGroups=groups.grep(/all/)
    	    	      if (dealerGroups[0] !=nil) 
    	    	    tempGroup=dealerGroups[0].split('|')
    	    	    temp_dealer_group=tempGroup[0].split('.')
    	    	    return temp_dealer_group[1]
    	    else
    	    	  return nil
    	    end
    	    
    end

end
