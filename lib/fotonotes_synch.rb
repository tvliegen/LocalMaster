class FotonotesSynch
	
	
	
	def initialize()
	end




def get_media(media_id)

    api_endpoint = 'https://api.fotonotes.com'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: true} ) do |faraday|
  	faraday.response :logger                  # log requests to STDOUT
  	faraday.adapter :net_http   # make requests with Net::HTTP
	faraday.basic_auth '190017-api', 'teknionapi'    
    end

   

    getResult=conn.get do |req|
  	req.url '/customer_api/1_0/media/image/' + media_id
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


def fn_con

    api_endpoint = 'https://teknion.fotonotes.com'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: true} ) do |faraday|
  	faraday.response :logger                  # log requests to STDOUT
  	faraday.adapter :net_http   # make requests with Net::HTTP
	faraday.basic_auth 'tkn-api', 'teknion987'  
	faraday.headers['API_KEY']='tkn201411'
	faraday.headers['Content-Type'] = 'json'
    end

   
    return conn
   
end

def getClaims
  
  rawClaims=fn_con.get do |req|
  
	req.url '/customer_api/1_0/projects?cross_portal=true&status=SUBMITTED&last_updated_after=20141201000000'
  	
  end
return rawClaims
  
end

def tekcare_push(claim)
  
   api_endpoint = 'http://api.corp.teknion.com'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: false} ) do |faraday|
  	faraday.response :logger                  # log requests to STDOUT
  	faraday.adapter :net_http   # make requests with Net::HTTP
	
    end

   

    getResult=conn.post do |req|
  	req.url '/tekcare/claims?dealer_code=190017'
  	req.body = claim
	req.headers['Authorization']='fotonotes ec457d0a974c48d5685a7efa03d137dc8bbde7e3'
	req.headers['Content-Type'] = 'application/json'
    end
    
    return getResult
    
end
end