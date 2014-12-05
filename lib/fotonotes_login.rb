class FotonotesLogin
	
	@@errCode=nil
	
	def errors
		return @@errCode
	end
	
	def initialize()
	end


	
	
def login
	@@errCode=nil
		
		@loginResult =JSON.parse(RestClient.post("https://teknion.fotonotes.com/customer_api/1_0/user/token" ,
	
	{"username" => "tkn-user"}.to_json, :accept => :json, :content_type => :json,'authorization'=> 'Basic dGtuLWFwaTp0ZXN0','API_KEY'=>'tkn201411' ))

	

	return @loginResult
end



	
end
