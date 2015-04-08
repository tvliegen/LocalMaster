class IdpLogin
	
	@@errCode=nil
	
	def errors
		return @@errCode
	end
	
	def initialize()
	end
	def getGroups(idp_id,type)
		@@errCode=nil
		
			group_profile_raw = Idp::User.get_groups(idp_id)
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
	
	






def findperson(searchname)
	@@errCode=nil
	 begin	
	 	 @user_profile_raw = JSON.parse(RestClient.get "https://teknion.oktapreview.com/api/v1/users/?q=#{searchname}",
	
	'authorization'=> 'SSWS 00XLL77OIjaIDX94bYuQF8Xp4GOOYWiWUry5V0b5k7',:accept => :json, :content_type => :json)
	rescue => e
		e.to_s
		@@errCode="Issue retrieving Profile"
	end
	return @user_profile_raw
end







def getAllGroups(type)


		group_profile_raw = Idp::User.all_groups

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
	
	
	
end
