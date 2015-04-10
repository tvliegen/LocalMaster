class Idp::User < Idp::Base

 attribute :id, String
 attribute :userId, String
 attribute :mfaActive, String
 attribute :cookieTokenUrl, String
 attribute :errorCode
 attribute :errorSummary, String
 attribute :errorLink, String
 attribute :errorId, String
 attribute :errorCauses, Array
  
  def self.validate_user(username,password)
  validate_response = client.post do |req|
        req.url "api/v1/sessions?additionalFields=cookieTokenUrl"
        req.headers['Content-Type'] = 'application/json'
        req.body ={"username" => username,"password" => password}.to_json
      end
   login_response = JSON.parse(validate_response.body)
   return login_response
   
  end
  def self.activate_user(idp_id)
  validate_response = client.post do |req|
        req.url "api/v1/users/#{idp_id}/lifecycle/activate?sendEmail=false"
        req.headers['Content-Type'] = 'application/json'
      end
   login_response = JSON.parse(validate_response.body)
   return login_response
   
  end
   def self.validate_session(session_id)
  validate_response = client.post do |req|
        req.url "api/v1/sessions/#{session_id}"
        req.headers['Content-Type'] = 'application/json'
        req.body ={"username" => username,"password" => password}.to_json
      end
   login_response = JSON.parse(validate_response.body)
   return login_response
   
  end
  
  
   
  
   def self.change_password(user_id,newpassword,oldpassword)
     password_value={"value" => newpassword}
     oldpassword_value={"value" => oldpassword}
  validate_response = client.post do |req|
        req.url "api/v1/users/#{user_id}/credentials/change_password"
        req.headers['Content-Type'] = 'application/json'
        req.body ={"oldPassword" => oldpassword_value,"newPassword" => password_value}.to_json
      end
   login_response = JSON.parse(validate_response.body)
   return login_response

  end
  
   def self.get_groups(idp_id)
  group_response = client.get do |req|
        req.url "api/v1/users/#{idp_id}/groups"
        req.headers['Content-Type'] = 'application/json'
      end
   group_result = JSON.parse(group_response.body)
   return group_result
   
  end
 
   def self.get_profile(idp_id)
  profile_response = client.get do |req|
        req.url "api/v1/users/#{idp_id}"
        req.headers['Content-Type'] = 'application/json'
      end
   profile_result = JSON.parse(profile_response.body)
   return profile_result
   
  end
  
  def self.get_group_members(group_id)
  group_response = client.get do |req|
        req.url "api/v1/groups/#{group_id}/users"
        req.headers['Content-Type'] = 'application/json'
      end
   group_result = JSON.parse(group_response.body)
   return group_result
   
  end
  
  def self.check_user(user_id)
    
    valid_user=false
  group_response = client.get do |req|
        req.url "api/v1/users/#{user_id}"
        req.headers['Content-Type'] = 'application/json'
      end
   group_result = JSON.parse(group_response.body)
   
   if group_result.key?'id'
      valid_user=true
   end
   
   return valid_user
   
  end
  
   def self.get_user_id(user_id)
    
    
  group_response = client.get do |req|
        req.url "api/v1/users/#{user_id}"
        req.headers['Content-Type'] = 'application/json'
      end
   group_result = JSON.parse(group_response.body)
   
   return group_result['id']
   
  end
   def self.find_group(group_name)
  group_response = client.get do |req|
        req.url "/api/v1/groups?q=#{group_name}"
        req.headers['Content-Type'] = 'application/json'
      end
   group_result = JSON.parse(group_response.body)
   return group_result
   
  end
  
     def self.all_groups
  group_response = client.get do |req|
        req.url "api/v1/groups"
        req.headers['Content-Type'] = 'application/json'
      end
   group_result = JSON.parse(group_response.body)
   return group_result
   
  end
  
   def self.add_user_to_group(group_id,user_id)
  group_response = client.put do |req|
        req.url "api/v1/groups/#{group_id}/users/#{user_id}"
        req.headers['Content-Type'] = 'application/json'
      end
   group_result = group_response.body
   return group_result
   
  end
   def self.remove_user_from_group(group_id,user_id)
  group_response = client.delete do |req|
        req.url "api/v1/groups/#{group_id}/users/#{user_id}"
        req.headers['Content-Type'] = 'application/json'
      end
   group_result = group_response.body
   return group_result
   
  end
  
  
def self.update_profile(idp_id,profile_info)
       profile_response = client.put do |req|
        req.url "api/v1/users/#{idp_id}"
        req.headers['Content-Type'] = 'application/json'
	req.body=profile_info.to_json
      end
   profile_result = JSON.parse(profile_response.body)
   return profile_result
end


def self.createProfile(profileHash)
  
  profile_response = client.post do |req|
        req.url "api/v1/users?activate=true"
        req.headers['Content-Type'] = 'application/json'
	req.body=profileHash.to_json
      end
   profile_result = JSON.parse(profile_response.body)
   return profile_result
   
  end
	

def self.deactivate(idp_id)
       profile_response = client.post do |req|
        req.url "api/v1/users/#{idp_id}/lifecycle/deactivate"
        req.headers['Content-Type'] = 'application/json'
	req.body=''
      end
   profile_result = JSON.parse(profile_response.body)
   return profile_result
end
end
