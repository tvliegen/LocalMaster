class Teknionline::ProfilesController < ApplicationController


  
  def edit
  	  
 idp_id=session["idp_id"]

  	 	
  	   	  
user_profile_raw=Idp::User.get_profile(idp_id)

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
    
    #render text:params['changepassword']['accepted']

    @user_profile = Teknionline::Profile.new(user_profile_params)
  	    
  	    
  	     idp_id=session["idp_id"]

  	 	
  	   	   @idp=IdpLogin.new
user_profile_raw=Idp::User.get_profile(idp_id)
  profileHash=JSON.parse(user_profile_raw.to_json)
  
  
  profileHash["profile"]["firstName"]=params[:teknionline_profile]["firstname"]
   profileHash["profile"]["lastName"]=params[:teknionline_profile]["lastname"]
    profileHash["profile"]["email"]=params[:teknionline_profile]["email"]
    
    if params['changepassword']['accepted'].eql? 'yes'

     @passwordChange=Idp::User.change_password(idp_id,params[:teknionline_profile]["newpassword"],params[:teknionline_profile]["currentpassword"])
      
    end
       idp_id=session["idp_id"]

         @idp=IdpLogin.new
     @updateResults=Idp::User.update_profile(idp_id,profileHash)
  

redirect_to "/login/authenticates/setsession"

    end

    def switch
    	    session[:DealerCode]=params[:id]
    	  redirect_to "/login/authenticates/loginfn?redirect=/tekcare/claims"
    end
    def user_profile_params
    	    
    	      params.permit(:firstname, :lastname, :email, :language)
              
    end    
end
