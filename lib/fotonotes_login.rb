class FotonotesLogin
	
	@@errCode=nil
	
	def errors
		return @@errCode
	end
	
	def initialize()
	end


	
	
def login(username,dealercode)

    api_endpoint = 'https://teknion.fotonotes.com'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: true} ) do |faraday|
  	faraday.response :logger                  # log requests to STDOUT
  	faraday.adapter :net_http   # make requests with Net::HTTP
	faraday.basic_auth dealercode + '-api', 'teknionapi'      
    end

    tempname=username.split("@")
    fotonotesname=Hash.new
    fotonotesname['username']=tempname[0] + "." + dealercode + "@" + tempname[1]

    loginResult=conn.post do |req|
  	req.url '/customer_api/1_0/user/token'
  	req.body = fotonotesname.to_json 
	req.headers['API_KEY']=dealercode
	req.headers['Content-Type'] = 'json'
    end
    begin
      returnToken=JSON.parse(loginResult.body)["token"]
    rescue
      returnToken="";
    end
    return returnToken

end

def get_media(media_id,type)

  
    api_endpoint = 'https://api.fotonotes.com'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: true} ) do |faraday|
  	faraday.response :logger                  # log requests to STDOUT
  	faraday.adapter :net_http   # make requests with Net::HTTP
	faraday.basic_auth '190017-api', 'teknionapi'    
    end

   case type
     
   when 'image'
     url='/customer_api/1_0/media/image/' + media_id
   when 'audio'
     url='/customer_api/1_0/media/audio/' + media_id
   when 'doc'
     url='/customer_api/1_0/document/' + media_id
   end

    getResult=conn.get do |req|
  	req.url url
  	req.body = ''
	req.headers['API_KEY']='190017'
	#req.headers['Content-Type'] = 'json'
    end
    begin
      returnImage=getResult.body
    rescue
      returnImage=nil
    end
    return returnImage

end


def master_login

    api_endpoint = 'https://teknion.fotonotes.com'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: true} ) do |faraday|
  	faraday.response :logger                  # log requests to STDOUT
  	faraday.adapter :net_http   # make requests with Net::HTTP
	faraday.basic_auth 'tkn-api', 'teknion987'      
    end

   
    fotonotesname=Hash.new
    fotonotesname['username']='tkn-api'

    loginResult=conn.post do |req|
  	req.url '/customer_api/1_0/user/token'
  	req.body = fotonotesname.to_json 
	req.headers['API_KEY']='tkn201411'
	req.headers['Content-Type'] = 'json'
    end
    begin
      returnToken=JSON.parse(loginResult.body)["token"]
    rescue
      returnToken="";
    end
    return returnToken

end


	
end
