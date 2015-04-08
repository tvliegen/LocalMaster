class Utilities::AttachmentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout false
  
  REQUEST_TOKEN='Bearer mynewtoken'
  
  def get_folder_contents
last_token=JSON.parse(Utilities::Boxtoken.last.to_json)

new_tokens = Boxr::refresh_tokens(last_token['RefreshToken'],
						box_client_id: ENV['BOX_CLIENT_ID'],
						box_client_secret: ENV['BOX_CLIENT_SECRET'])
    box_tokens = Utilities::Boxtoken.new(RefreshToken: new_tokens.refresh_token,AccessToken: new_tokens.access_token)
					box_tokens.save!
Utilities::Boxtoken.delete_all(['id NOT IN (?)', Utilities::Boxtoken.last(5).collect(&:id)])
   client = Boxr::Client.new(new_tokens.access_token)

   folder = client.search('2015-000141-001')
   
   entries=JSON.parse(folder.to_json)
   
   file_names=Array.new
   entries.each do |file_name|
     temp=Hash.new
     temp['Name']=file_name['name']
     temp['url']=client.download_url(file_name['id'], version: nil)
     temp['id']=file_name['id']
     file_names.push(temp)
   end
   render text: entries.to_json
   
   end
  def get_folder_contents2
 
   client = Boxr::Client.new('5ShfpwKMoWXZoR8WkeVtPUMH5MUpSEDQ')

   folder = client.folder_from_id('3261463700')
   entries=JSON.parse(folder['item_collection']['entries'].to_json)
   
   file_names=Array.new
   entries.each do |file_name|
     temp=Hash.new
     temp['Name']=file_name['name']
     temp['url']=client.download_url(file_name['id'], version: nil)
     temp['id']=file_name['id']
     file_names.push(temp)
   end
   render text: entries

  end
  
  def new
    
    
  end
  
  def foreign_upload
 # attach=Attachments.new
 #     results=attach.process_file(params['teknion_clarification']['file_uploaded'],['Tekcare',params[:claim_issue_id]],'None')
    request_token=request.headers['Token'].to_s
    request_body=params
    
   # application=request_body['Application']
    valid_token=false
    if request_token.eql?REQUEST_TOKEN then
       valid_token=true
    end
    
    
    render text: out_message.to_json, status: :ok
  
  
  end
  
  def get_from_fn
    @fn=FotonotesLogin.new
  
 # fn_token=@fn.login('tkn-api','teknion987')
    # attach=Attachments.new
 #     results=attach.process_file(params['teknion_clarification']['file_uploaded'],['Tekcare',params[:claim_issue_id]],'None')
    request_token=request.headers['Token'].to_s
    request_body=params
    
   # application=request_body['Application']
    valid_token=false
    if request_token.eql?REQUEST_TOKEN then
       valid_token=true
    end
    
    if valid_token then
      status_out= :ok
    else
      status_out= :forbidden
    end
    
    render text: "None".to_json, status: status_out
  end
  
  def upload
   
   
      upload_result=process_file(params[:file_uploaded],['Tekcare','2015-00001-001'])  
   
    render text:upload_result

    
  end
  
  def getfile
    
  end
  
private

def process_file(tbd_file,file_tags)
  uploaded_io = tbd_file
  File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
  end
  
  results=upload_file(uploaded_io.original_filename,uploaded_io.original_filename,Rails.root.join('public', 'uploads').to_s,'3261463700','bA0BKfWsPYyZDeCB2ZLmfqplXqdheq9K',file_tags)
  result_json=JSON.parse(results.body)
  if result_json['entries'].nil?
    results=upload_file(uploaded_io.original_filename,Time.new.to_s + "_" + uploaded_io.original_filename,Rails.root.join('public', 'uploads').to_s,'3261463700','bA0BKfWsPYyZDeCB2ZLmfqplXqdheq9K',file_tags)
    result_json=JSON.parse(results.body)
  else
    file_id=result_json['entries'][0]['id']
    final_result=add_tags(file_id,file_tags,token)
  end
  return result_json
end


 def upload_file(filename,actual_name,path,folder,token,file_tags)
    api_endpoint = 'https://upload.box.com'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: true} ) do |faraday|
  	faraday.response :logger                 
	faraday.request :multipart
	faraday.request :url_encoded
	faraday.headers['Authorization']='Bearer ' + token
	faraday.adapter Faraday.default_adapter

    end
    file_attributes=Hash.new
    headers=Hash.new
    parent_attribute=Hash.new
  
    file_attributes['name']=actual_name
    parent_attribute['id']=folder
    file_attributes['parent']=parent_attribute
   file_attributes[:content_created_at] =  DateTime.now.to_s
    file_attributes[:content_modified_at] =  DateTime.now.to_s
     
    payload = { 
      file: Faraday::UploadIO.new(path + "/" + filename, 'image/jpeg'), 
      attributes: file_attributes.to_json
		 
    }

     loginResult=conn.post '/api/2.0/files/content', payload

     return loginResult
    
 end
 
 def add_tags(file,file_tags,token)
   client = Boxr::Client.new('QywtCFjfbhGFRkXUobUHuaIvz9Nei4Wt')
   result=client.update_file(file, tags: file_tags)
   return result
 end
 
 
 def get_file(filename,token)
    api_endpoint = 'https://api.box.com'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: true} ) do |faraday|
  	faraday.response :logger                 
	faraday.headers['Authorization']='Bearer ' + token
	faraday.request :url_encoded
	faraday.adapter Faraday.default_adapter

    end

     result=conn.get '/2.0/search?query=' + filename 
     
     return result.body
 end
end
