class Teknionline::ProfilesController < ApplicationController


  
  def edit
  	  
 idp_id=session["idp_id"]

  	 	
  	   	   @idp=IdpLogin.new
user_profile_raw=@idp.getProfile(idp_id)

       @user_profile = Teknionline::Profile.new(user_profile_params)

@user_profile.firstname = user_profile_raw["profile"]["firstName"]
@user_profile.lastname = user_profile_raw["profile"]["lastName"]
@user_profile.email = user_profile_raw["profile"]["email"]
@user_profile.language = user_profile_raw["profile"]["language"]
@user_profile.login = user_profile_raw["profile"]["login"]


  end



 

  # PATCH/PUT /teknionline/profiles/1
  # PATCH/PUT /teknionline/profiles/1.json
  def update
  	    @user_profile = Teknionline::Profile.new(user_profile_params)
  	    
  	    
  	     idp_id=session["idp_id"]

  	 	
  	   	   @idp=IdpLogin.new
user_profile_raw=@idp.getProfile(idp_id)
  profileHash=JSON.parse(user_profile_raw.to_json)
  
  
  profileHash["profile"]["firstName"]=params[:teknionline_profile]["firstname"]
   profileHash["profile"]["lastName"]=params[:teknionline_profile]["lastname"]
    profileHash["profile"]["email"]=params[:teknionline_profile]["email"]
#     profileHash["profile"]["login"]=params[:teknionline_profile]["login"]
    #  profileHash["profile"]["mobilePhone"]=params[:teknionline_profile]["login"]
       idp_id=session["idp_id"]

         @idp=IdpLogin.new
     @updateResults=@idp.updateProfile(idp_id,profileHash)
   	
redirect_to "/login/authenticates/setsession"
    end

    def switch
    	    session[:DealerCode]=params[:id]
    	    redirect_to "/"
    end
    def user_profile_params
    	    
    	      params.permit(:firstname, :lastname, :email, :language)
              
    end    
end
