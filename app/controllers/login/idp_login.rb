class Login::IdpLogin
	
	@@errCode=nil
	
	def errors
		return @@errCode
	end
	
	def initialize()
	end
	def getGroups(idp_id,type)
		@@errCode=nil
	begin	
			group_profile_raw = JSON.parse(RestClient.get "https://teknion.oktapreview.com/api/v1/users/#{idp_id}/groups",
	
			'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7',:accept => :json, :content_type => :json)
		rescue => e
			e.to_s
			@@ErrCode="Issue Loading Groups"
		end

		$i=0

		@raw_groups=Array.new
		if (type=='names')

		while $i<group_profile_raw.length
			@accountName="#{group_profile_raw[$i]["profile"]["name"]}|#{group_profile_raw[$i]["profile"]["description"]}"
			@raw_groups.push(@accountName)
			$i +=1;
		end
	else
		while $i<group_profile_raw.length
			@accountName="#{group_profile_raw[$i]["id"]}|#{group_profile_raw[$i]["profile"]["name"]}|#{group_profile_raw[$i]["profile"]["description"]}"
			@raw_groups.push(@accountName)       
			$i +=1;
		end
	end
	return @raw_groups
	end
	
	
def login(username, password)
	@@errCode=nil
	begin	
		@loginResult =JSON.parse(RestClient.post("https://teknion.oktapreview.com/api/v1/sessions?additionalFields=cookieTokenUrl" ,
	
	{"username" => username,"password" => password}.to_json, :accept => :json, :content_type => :json,'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7' ))

	rescue => e
		e.to_s
		@@errCode="Invalid Username or Password!"
	end

	return @loginResult
end


def createProfile(profileHash)
	@@errCode=nil
	

	begin	
		@profileResult =JSON.parse(RestClient.post("https://teknion.oktapreview.com/api/v1/users?activate=true" ,
	
	profileHash.to_json, :accept => :json, :content_type => :json,'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7' ))

	rescue => e
		e.to_s
		@@errCode="Invalid Username or Password!"
	end

	return @profileResult
end
def getProfile(idp_id)
	@@errCode=nil
	 begin	
	 	 @user_profile_raw = JSON.parse(RestClient.get "https://teknion.oktapreview.com/api/v1/users/#{idp_id}",
	
	'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7',:accept => :json, :content_type => :json)
	rescue => e
		e.to_s
		@@errCode="Issue retrieving Profile"
	end
	return @user_profile_raw
end

def updateProfile(idp_id,profile_info)
		@@errCode=nil
	begin		
	 	 @user_profile_raw = JSON.parse(RestClient.put "https://teknion.oktapreview.com/api/v1/users/#{idp_id}",	
	JSON.generate(profile_info),	'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7',:accept => :json, :content_type => :json)

	rescue => e
			e.to_s
			@@ErrCode="Issue Loading Groups"
		end
	return @user_profile_raw
end

def getGroupMembers(group_id)
		@@errCode=nil
	begin	
			@group_members_raw = JSON.parse(RestClient.get "https://teknion.oktapreview.com/api/v1/groups/#{group_id}/users",
	
			'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7',:accept => :json, :content_type => :json)
		rescue => e
			e.to_s
			@@ErrCode="Issue Loading Groups"
		end

		$i=0

	return @group_members_raw
	end

def logout(session_id)
	@@errCode=nil
	begin	
		@logoutResult =JSON.parse(RestClient.delete("https://teknion.oktapreview.com/api/v1/sessions/#{session_id}" , :accept => :json, :content_type => :json,'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7' ))

	rescue => e
		e.to_s
		@@errCode="Invalid Username or Password!"
	end

	return @loginResult
end

def validate_session(session_id)
	@@errCode=nil
	#	begin	
		@loginResult =JSON.parse(RestClient.get("https://teknion.oktapreview.com/api/v1/sessions/#{session_id}" ,
	
	 :accept => :json, :content_type => :json,'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7' ))

#rescue => e
#		e.to_s
#		@@errCode="Invalid Username or Password!"
#	end


	return @loginResult
end

def getAllGroups(type)
		@@errCode=nil
	begin	
			group_profile_raw = JSON.parse(RestClient.get "https://teknion.oktapreview.com/api/v1/groups",
	
			'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7',:accept => :json, :content_type => :json)
		rescue => e
			e.to_s
			@@ErrCode="Issue Loading Groups"
		end

		$i=0

		@raw_groups=Array.new
		if (type=='names')

		while $i<group_profile_raw.length
			@accountName="#{group_profile_raw[$i]["profile"]["name"]}|#{group_profile_raw[$i]["profile"]["description"]}|#{group_profile_raw[$i]["id"]}"
			@raw_groups.push(@accountName)
			$i +=1;
		end
	else
		while $i<group_profile_raw.length
			@accountName="#{group_profile_raw[$i]["id"]}|#{group_profile_raw[$i]["profile"]["name"]}|#{group_profile_raw[$i]["profile"]["description"]}"
			@raw_groups.push(@accountName)       
			$i +=1;
		end
	end
	return @raw_groups
	end
	
	def addUserToGroup(group_id,user_id)
		@@errCode=nil
	begin	
		
	
			group_profile_raw = RestClient.put "https://teknion.oktapreview.com/api/v1/groups/#{group_id}/users/#{user_id}",{},
	
			'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7',:accept => :json, :content_type => :json
	#	rescue => e
	##		@@ErrCode="Issue Loading Groups"
		end
	end
	
	def removeUserFromGroup(group_id,user_id)
		@@errCode=nil
	begin	
			group_profile_raw = RestClient.delete "https://teknion.oktapreview.com/api/v1/groups/#{group_id}/users/#{user_id}",
	
			'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7',:accept => :json, :content_type => :json
	#	rescue => e
	#		e.to_s
	#		@@ErrCode="Issue Loading Groups"
		end
	end
	
end
