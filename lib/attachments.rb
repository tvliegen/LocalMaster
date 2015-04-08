class Attachments
  
  
  BOX_CODE = ENV['BOX_TOKEN']
  BOX_FOLDER = '3261463700'
 
  BOX_CLIENT_ID=ENV['BOX_CLIENT_ID'] #'5i4wcbiz853uqchhsybudcqba8tbqmnw'
  BOX_CLIENT_SECRET=ENV['BOX_CLIENT_SECRET']#'ix2erM93nH1BpbTdRr1mXAkfMRkqGPZh'
#  BOX_ACCESS = 'P6g8up8pItCWWpLfcjPhC5k0842juXEj'
  BOX_REFRESH='ZyypD8IURuS2T7EfOavPTLpJw9GXEOs0j1cVjpvLVJolUEmPz0u486dpgaG29iv0'
  @@BOX_TOKEN = ''
  
  def upload(file_uploaded,file_tags)
   
      return process_file(file_uploaded,file_tags)  
    
    
  end
def initialize
  
  last_token=JSON.parse(Utilities::Boxtoken.last.to_json)

new_tokens = Boxr::refresh_tokens(last_token['RefreshToken'],
						box_client_id: ENV['BOX_CLIENT_ID'],
						box_client_secret: ENV['BOX_CLIENT_SECRET'])
    box_tokens = Utilities::Boxtoken.new(RefreshToken: new_tokens.refresh_token,AccessToken: new_tokens.access_token)
					box_tokens.save!
Utilities::Boxtoken.delete_all(['id NOT IN (?)', Utilities::Boxtoken.last(5).collect(&:id)])
 
  @@BOX_TOKEN=new_tokens.access_token #
end

def get_folder_contents
 
   client = Boxr::Client.new(@@BOX_TOKEN)

   folder = client.folder_from_id(BOX_FOLDER)
   entries=JSON.parse(folder['item_collection']['entries'].to_json)
   
   file_names=Array.new
   entries.each do |file_name|
     temp=Hash.new
     temp['Name']=file_name['name']
     temp['url']=client.download_url(file_name['id'], version: nil)
     temp['id']=file_name['id']
     temp['date']=file_name['content_created_at']
     file_names.push(temp)
   end
  return file_names

  end

  def search_app_files(tags)
 
   client = Boxr::Client.new(@@BOX_TOKEN)
   folder = client.search(tags,content_types: 'tags')
   entries=JSON.parse(folder.to_json)
   
   file_names=Array.new
   entries.each do |file_name|
     temp=Hash.new
     temp['Name']=file_name['name']
     temp['url']=client.download_url(file_name['id'], version: nil)
     temp['id']=file_name['id']
     temp['date']=DateTime.parse(file_name['content_created_at'])
     temp['description']=file_name['description']
     file_names.push(temp)
   end
  return file_names

  end


def process_file(tbd_file,file_tags,file_description)
  uploaded_io = tbd_file
  File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
  end
  
  file_result=upload_file(uploaded_io.original_filename,uploaded_io.original_filename,Rails.root.join('public', 'uploads').to_s,file_description)
  result_json=JSON.parse(file_result.body)
  if result_json['entries'].nil?
    results=upload_file(uploaded_io.original_filename,Time.new.to_s + "_" + uploaded_io.original_filename,Rails.root.join('public', 'uploads').to_s,file_description)
    result_json=JSON.parse(results.body)
  end
  file_id=result_json['entries'][0]['id']
  final_result=add_tags(file_id,file_tags)
  return final_result
end

def process_direct_file(tbd_file,file_tags,file_description)
  uploaded_io = tbd_file
  file_result=upload_file(uploaded_io,uploaded_io,Rails.root.join('public', 'uploads').to_s,file_description)
  result_json=JSON.parse(file_result.body)
  
  if result_json['entries'].nil?
    results=upload_file(uploaded_io,Time.new.to_s + "_" + uploaded_io,Rails.root.join('public', 'uploads').to_s,file_description)
    result_json=JSON.parse(results.body)
  end
  file_id=result_json['entries'][0]['id']
  final_result=add_tags(file_id,file_tags)
  return final_result
end



 def add_tags(file,file_tags)
   client = Boxr::Client.new(@@BOX_TOKEN)
   result=client.update_file(file, tags: file_tags)
   return result
 end

 def upload_file(filename,name,path,file_description)
     api_endpoint = 'https://upload.box.com'
    conn ||= Faraday.new(api_endpoint, ssl: {verify: true} ) do |faraday|
  	faraday.response :logger                 
	faraday.request :multipart
	faraday.request :url_encoded
	faraday.headers['Authorization']='Bearer ' + @@BOX_TOKEN
	faraday.adapter Faraday.default_adapter

    end
    file_attributes=Hash.new
    headers=Hash.new
    parent_attribute=Hash.new
    file_attributes['name']=name
    parent_attribute['id']=BOX_FOLDER
    file_attributes['parent']=parent_attribute
    parent_attribute['description']=file_description
 
    payload = { 
      file: Faraday::UploadIO.new(path + "/" + filename, 'image/jpeg'), 
      attributes: file_attributes.to_json
		 
    }

     upload_result=conn.post '/api/2.0/files/content', payload
     return upload_result
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
 
