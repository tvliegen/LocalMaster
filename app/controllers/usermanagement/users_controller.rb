class Usermanagement::UsersController < ApplicationController


  # GET /usermanagement/users
  # GET /usermanagement/users.json
  def index
  	  @usermanagement_users = Usermanagement::User.all
  	  @idp=IdpLogin.new
  	  @dealerGroups=@idp.getGroups(session[:idp_id],'full').grep(/all/)
  	  dealerCode=session[:DealerCode]
  	  group_id=@dealerGroups.grep(/#{dealerCode}/)[0].split('|')[0]
  	  @profiles=Usermanagement::Profile.new
  	  group_members_raw = Idp::User.get_group_members(group_id)
  	  $i=0
  	  
  	  @raw_members=Array.new
  	  
  	  while $i<group_members_raw.length
  	  	  @profiles=Usermanagement::Profile.new
  	  	  @profiles.idpid=group_members_raw[$i]["id"]
  	  	  @profiles.firstname=group_members_raw[$i]["profile"]["firstName"]
  	  	  @profiles.lastname=group_members_raw[$i]["profile"]["lastName"]
  	  	  @profiles.login=group_members_raw[$i]["profile"]["login"]
  	  	  @profiles.lastlogin=group_members_raw[$i]["lastLogin"]
  	  	  
  	  	  $i +=1;
  	  	  @raw_members.push(@profiles)
  	  end
	
  end
  
  
  # GET /usermanagement/users/new
  def new
    @usermanagement_user = Usermanagement::User.new
    @user_profile = Usermanagement::User.new(usermanagement_user_params)
  end
  
  def addstep2
    @usermanagement_user = Usermanagement::User.new
    @user_profile = Usermanagement::User.new(usermanagement_user_params)
  end
  
  def search
    @idp=IdpLogin.new
    @search_results=Hash.new
    @search_results = @idp.findperson(params[:search])  
  end
  

  # POST /usermanagement/users
  # POST /usermanagement/users.json
  
  
  def create
  	  @usermanagement_user = Usermanagement::User.new(usermanagement_user_params)
  	  @user_profile = Usermanagement::User.new(usermanagement_user_params)
  	  @idp=IdpLogin.new
  	  profileHash=JSON.parse('{
  	  	  "profile": {
  	  	  "firstName": "",
  	  	  "lastName": "",
  	  	  "email": "",
  	  	  "login": "",
  	  	  "mobilePhone": ""
  	  	  },
  	  	  "credentials": {
		    "password" : { "value": "" }
  	  	  }
		  }
  	  	  ')
  	  profileHash["profile"]["firstName"]=params[:usermanagement_user]["firstname"]
  	  profileHash["profile"]["lastName"]=params[:usermanagement_user]["lastname"]
  	  profileHash["profile"]["email"]=params[:usermanagement_user]["email"]
  	  profileHash["profile"]["login"]=params[:usermanagement_user]["login"]
  	  profileHash["profile"]["mobilePhone"]=params[:usermanagement_user]["mobile"]
	  passwordvalue=Hash.new
	  passwordvalue['value']=params[:usermanagement_user]["password"]
	  recovery=Hash.new
	  recovery['question']='What colour is the sky?'
	  recovery['answer']='blue'
	  profileHash["credentials"]["password"]=passwordvalue
	  profileHash["credentials"]["recovery_question"]=recovery
	 
	  new_user=Idp::User.createProfile(profileHash)
  	  
  	   @dealerGroups=@idp.getGroups(session[:idp_id],'full').grep(/all/)
  	  dealerCode=session[:DealerCode]
  	  group_id=@dealerGroups.grep(/#{dealerCode}/)[0].split('|')[0]
  	  
  	  Idp::User.add_user_to_group(group_id,new_user["id"])
	  
  	  redirect_to '/usermanagement/users/'

  end

 
  
  def update
  	#  
  	@user_profile = Usermanagement::User.new(usermanagement_user_params)
  	
  	
  	idp_id=params["id"]
  	
  	@idp=IdpLogin.new
  	
  	user_profile_raw=Idp::User.get_profile(idp_id)
  	profileHash=JSON.parse(user_profile_raw.to_json)
  	
  	
	profileHash["profile"]["firstName"]=params[:usermanagement_user]["firstname"]
  	  profileHash["profile"]["lastName"]=params[:usermanagement_user]["lastname"]
  	  profileHash["profile"]["email"]=params[:usermanagement_user]["email"]
  	  profileHash["profile"]["login"]=params[:usermanagement_user]["login"]
  	  profileHash["profile"]["mobilePhone"]=params[:usermanagement_user]["mobile"]
	  passwordvalue=Hash.new
	  passwordvalue['value']=params[:usermanagement_user]["password"]
	
  	
  	recovery=Hash.new
	  recovery['question']='What colour is the sky?'
	  recovery['answer']='blue'
	  profileHash["credentials"]["password"]=passwordvalue
	  profileHash["credentials"]["recovery_question"]=recovery
	  
  	@updateResults=Idp::User.update_profile(idp_id,profileHash)
	
  	@all_groups=@idp.getAllGroups('names')
  	@AccessibleGroups=@all_groups.grep(/#{session[:DealerCode]}/)
  	 if params.key?'groups'
	  new_groups=params[:groups]["enabled"] 
	 else
	   new_groups=Hash.new 
	 end
  	 my_groups=@idp.getGroups(idp_id,'raw')
  	
  	  @AccessibleGroups.each do |accessible_group|
  	  	    group_id=accessible_group.split("|")[2]
  	  	  if !(my_groups.grep(/#{accessible_group}/).empty?)  	  	  	
  	  	  	  if (new_groups.grep(/#{group_id}/).empty?)  
  	  	  	  	  # Remove from Group
  	  	  	  	 Idp::User.remove_user_from_group(group_id,idp_id)
  	  	  	  end
  	  	  else
  	  	  	if !(new_groups.grep(/#{group_id}/).empty?)  
  	  	  	
  	  	  	  	 Idp::User.add_user_to_group(group_id,idp_id)
  	  	  	  	 	
  	  	  	  end  
  	  	  end
  	  	
    	     	  
  	  	  
  	  end	
	  
	my_groups=@idp.getGroups(idp_id,'raw')
	
	if my_groups.length==1
	  Idp::User.deactivate(idp_id)
	end
  	redirect_to '/usermanagement/users'

  end

  # DELETE /usermanagement/users/1
  # DELETE /usermanagement/users/1.json
  def destroy
    @usermanagement_user.destroy
    respond_to do |format|
      format.html { redirect_to usermanagement_users_url }
      format.json { head :no_content }
    end
  end

 
  def edit
  	  
  	  idp_id=params["id"]
  	  
  	  
  	  @idp=IdpLogin.new
  	  user_profile_raw=Idp::User.get_profile(idp_id)
  	  
  	  @user_profile = Usermanagement::User.new(usermanagement_user_params)
  	  
  	  @user_profile.firstname = user_profile_raw["profile"]["firstName"]
  	  @user_profile.lastname = user_profile_raw["profile"]["lastName"]
  	  @user_profile.email = user_profile_raw["profile"]["email"]
  	  @user_profile.language = user_profile_raw["profile"]["language"]
  	  @user_profile.login = user_profile_raw["profile"]["login"]
  	  @user_profile.mobile = user_profile_raw["profile"]["mobile"]
  	  
  	 @all_groups=@idp.getAllGroups('names')
  	  @AccessibleGroups=@all_groups.grep(/#{session[:DealerCode]}/)
  	
  	  
  	  my_groups=@idp.getGroups(idp_id,'raw')
  	 userGroups=Array.new
  	  @AccessibleGroups.each do |accessible_group|
  	  	  
  	  	  if !(my_groups.grep(/#{accessible_group}/).empty?)   
  	  	  	  group_name=accessible_group+'|true'
  	  	  else
  	  	  	  group_name=accessible_group+'|false'    
  	  	  end
  	  	  userGroups.push(group_name)
    	     	  
  	  	  
  	  end	
  	  
  	  @user_profile.groups=userGroups

  end
  
  def addotheruser
    
    logger.info "adduser"
       @idp=IdpLogin.new
       @dealerGroups=@idp.getGroups(session[:idp_id],'full').grep(/all/)
       dealerCode=session[:DealerCode]
       group_id=@dealerGroups.grep(/#{dealerCode}/)[0].split('|')[0]
       
       render text: params
  	  
  #	  @idp.addUserToGroup(group_id,new_user["id"])
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usermanagement_user
      @usermanagement_user = Usermanagement::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usermanagement_user_params
    	      params.permit(:firstname, :lastname, :email, :language, :login, :mobile, :password, :password_confim,:groups)

    end
end
