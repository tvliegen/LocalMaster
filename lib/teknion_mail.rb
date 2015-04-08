class TeknionMail
	
	
	
def sendMessage(content)

    api_endpoint = 'https://api.postmarkapp.com'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: true} ) do |faraday|
  	faraday.response :logger                  # log requests to STDOUT
  	faraday.adapter :net_http   # make requests with Net::HTTP   
    end


    messageResponse=conn.post do |req|
  	req.url '/email'
  	req.body = content.to_json
	req.headers['X-Postmark-Server-Token']= ENV['MAIL_TOKEN'] ? ENV['MAIL_TOKEN'] : 'f97ff2b8-4ccc-4524-866b-791857a3190e'
	req.headers['Content-Type'] = 'application/json'
	req.headers['Accept'] = 'application/json'
	
    end
   return messageResponse

end



	
end
