
class Login::AuthenticatesController < ApplicationController

  def login
    @login_authenticate = Login::Authenticate.new
    @errCode=nil
  end


  def idpLogin
  	  @login_authenticate = Login::Authenticate.new(login_authenticate_params)
     
	@idp=Login::IdpLogin.new
	@errCode = nil
	loginResults=@idp.login(@login_authenticate.username, @login_authenticate.password)


	

if @idp.errors.eql?nil

	
	idp_id=loginResults["userId"]
	session[:session_cookie]=loginResults["cookieTokenUrl"]
	
	session[:idp_session_id]=loginResults["id"]
	session[:idp_id]=idp_id
	set_session

	
else   
	respond_to do |format|
	  format.html { render action: 'login' }
    #    format.json { render json: @login_authenticate.errors, status: :unprocessable_entity }
end
      end




end

 
def set_session
	@idp=Login::IdpLogin.new
	idp_id=session[:idp_id]
	@user_profile_raw=@idp.getProfile(idp_id)
	session[:FirstName] =@user_profile_raw["profile"]["firstName"]
	session[:LastName] = @user_profile_raw["profile"]["lastName"]
	session[:Language] = @user_profile_raw["profile"]["language"]
	
	session[:Groups]=@idp.getGroups(idp_id,'names')
	session[:DealerCode]=set_default_dealercode
	
	respond_to do |format|
      
      	     format.html { redirect_to "/" }
	end
end

 def validate_session
 @idp=Login::IdpLogin.new
	@errCode = nil	 
	session_result=@idp.validate_session(session[:idp_session_id])
	redirect_to "/"
 end
 
 def logout
 	  	 session[:userid] = nil
    
	session[:FirstName] =nil
	session[:LastName] = nil
	session[:Language] = nil
	session[:Groups]= nil
	session[:session_cookie]=nil
	session[:session_id]=nil
	session[:idp_id]=nil
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
