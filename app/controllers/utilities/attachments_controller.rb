class Utilities::AttachmentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout false
  
  REQUEST_TOKEN='Bearer mynewtoken'
  
 
  
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
    

    request_token=request.headers['Token'].to_s
    request_body=JSON.parse(params.to_json)
    
     fn_media_id=request_body['FN ID']
     fn_file_name=request_body['File Name']
    application_name=request_body['Application']
    tags=Array.new
    
    request_body['Tags'].each do |tag|
      tags.push(tag['tag'])
    end
   
    tags.push(application_name)
    @fn=FotonotesLogin.new
  
  fn_result=@fn.get_media(fn_media_id)
    
      File.open(Rails.root.join('public', 'uploads', fn_file_name), 'wb') do |file|
    file.write(fn_result)
  end
    attach=Attachments.new
    results=attach.process_direct_file(fn_file_name,tags,'None')
    
    valid_token=false
    if request_token.eql?REQUEST_TOKEN then
       valid_token=true
    end
    
    if valid_token then
      status_out= :ok
    else
      status_out= :forbidden
    end
    
    #render inline: '<img src="/uploads/temp.jpg">'
    render text: results.to_json, status: status_out
  end
  
 
end
