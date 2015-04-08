class Utilities::UtilController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout false
  
  def pullfn
    claim_ids=Array.new
    fn_synch=FotonotesSynch.new
    claim_count=0
    fnClaims=JSON.parse(fn_synch.getClaims.body)
    fnClaims.each do |claim|
      claim_count=claim_count+1
      tekcare_push_result=fn_synch.tekcare_push(outputClaim(claim).to_json)
      claim_test=outputClaim(claim).to_json

   results=JSON.parse(tekcare_push_result.body)
   results['claim_issues'].each do |claim_issue_result|
    claim_issue_result['images'].each do |image_entry|
      if image_entry['uri'].eql?'none'
	id=image_entry['image_name']
	file_name=image_entry['image_name'] + ".jpg"
	tags = ['Tekcare',claim_issue_result['issue_id']]
	get_from_fn(id,file_name,tags,'image')
	file_name=image_entry['image_name'] + ".mp3"
	get_from_fn(id,file_name,tags,'audio')
      else
	id=image_entry['image_name']
	file_name=image_entry['uri']
	tags = ['Tekcare',claim_issue_result['issue_id']]
	get_from_fn(id,file_name,tags,'doc')

      end
    end
   end

   end
   render text: claim_count.to_s + ' claims(s) processed'
  end
  
  def outputClaim(claim)
    masterOut=Hash.new
    
    dealerSection=claim['sections'][0]
    claimSection=claim['sections'][1]
    installerSection=claim['sections'][2]

    masterOut['customer']=Hash.new
    masterOut['customer']["dealer_code"]=getField(dealerSection,"dealer_code")
    masterOut['customer']["dealer_code"]=getField(dealerSection, "dealer_code")
    masterOut['customer']["dealer_contact_email"]=getField(dealerSection, "dealer_contact_email")
    masterOut['customer']["dealer_contact_name"]=getField(dealerSection, "dealer_contact_name")
    masterOut['customer']["dealer_contact_number"]=getField(dealerSection, "dealer_contact_number")
    masterOut['customer']["dealer_name"]=getField(dealerSection, "dealer_name")
    masterOut['customer']["dealer_address1"]=getField(dealerSection, "dealer_address_1")
    masterOut['customer']["dealer_address2"]=getField(dealerSection, "dealer_address_2")
    masterOut['customer']["dealer_city"]=getField(dealerSection, "dealer_city")
    masterOut['customer']["dealer_province_state"]=getField(dealerSection, "dealer_province_state")
    masterOut['customer']["dealer_country"]=getField(dealerSection, "dealer_countryname")
    masterOut['customer']["dealer_postal_zip"]=getField(dealerSection, "dealer_postal_zip")
    masterOut['customer']["end_customer_name"]=getField(dealerSection, "end_customer_name")
    
    
    masterOut['header']=Hash.new
    masterOut['header']["claim_description"]=getField(claimSection, "claim_title")
    masterOut['header']["external_claim_id"]=claim['id']
    masterOut['header']["est_install_complete_date"]=getField(installerSection, "scheduled_installation_completion_date")
    masterOut['header']["installation_company"]=getField(installerSection, "installation_company")
    masterOut['header']["po_number"]=getField(claimSection, "po")
    masterOut['header']["billing_number"]=getField(claimSection,"billing_number")
    
    if !getField(claimSection, "shipment_number").nil?
        
        masterOut['header']["shipment_number"]=getField(claimSection, "shipment_number")
     
     else
     
     	masterOut['header']["shipment_number"]='0'
     	
    end
    masterOut['header']["site_number"]=1
    masterOut['header']["sq_number"]=getField(claimSection, "sq")
    masterOut['header']["sq_revision_number"]=getField(claimSection, "sq_rev").to_i
    masterOut['header']["universal_number"]=getField(claimSection, "universal").to_i
    masterOut['header']["product_receive_date"]=getField(claimSection, "shipment_received_date")
    masterOut['header']["product_in_storage"]=getField(installerSection, "product_in_storage")
    masterOut['header']["project_name"]=getField(dealerSection, "project_name")
    masterOut['header']["install_in_progress"]=getField(installerSection, "installation_in_process")
    masterOut['header']["install_contact_name"]=getField(installerSection, "installer_name")
    masterOut['header']["install_date"]=getField(installerSection, "scheduled_installation_completion_date")
    masterOut['header']["installation_lead_contact_name"]=getField(installerSection, "installer_name")
    masterOut['header']["installation_lead_contact_phone"]=getField(installerSection, "installer_number")
    masterOut['header']["installation_lead_contact_email"]=getField(installerSection, "installer_email")
    masterOut['header']["site_contact_name"]=""
    masterOut['header']["site_contact_number"]= ""
    masterOut['header']["site_contact_email"]= ""

    masterOut['ship_replacement_to']=Hash.new
    masterOut['ship_replacement_to']["address1"]=getField(claimSection, "replacement_ship_to_address")
    masterOut['ship_replacement_to']["address2"]="none"
    masterOut['ship_replacement_to']["ah_name"]=getField(claimSection, "after_hours_contact_name_1423143297568")
    masterOut['ship_replacement_to']["ah_number"]=getField(claimSection, "after_hours_contact_number_1423143313664")
    masterOut['ship_replacement_to']["cb_name"]=getField(claimSection, "call_before_delivery_name")
    masterOut['ship_replacement_to']["cb_number"]=getField(claimSection, "call_before_contact_number")
    masterOut['ship_replacement_to']["city"]=getField(claimSection, "replacement_ship_to_city")
    masterOut['ship_replacement_to']["country"]=getField(claimSection, "replacement_shipment_country")
    masterOut['ship_replacement_to']["postal_zip"]=getField(claimSection, "replacement_ship_to_zip")
    masterOut['ship_replacement_to']["shipto_name"]=getField(claimSection, "replacement_ship_to_name")
    masterOut['ship_replacement_to']["state_prov"]=getField(claimSection, "replacement_ship_to_state")
    masterOut['ship_replacement_to']["email"]=getField(claimSection, "replacement_order_email")

    masterOut['claim_issues']=Array.new
    
    if getField(claimSection,"claim_type").eql?'Product'
    claimIssues=claim["contained_items"]
    
    claimIssues.each do |issue|
      masterOut['claim_issues'].push(createIssue(issue))
      
    end
    else
      masterOut['claim_issues'].push(createFreightIssue(claim['documents']))
    end
    return masterOut
  end
  
  private
  
  def getField(section, key)
    field_value=""
    section['fields'].each do |field|
      if field['key'].eql?key
	field_value=field['value']
	break
    end
    end
    if field_value.nil?
      field_value=""
    end
    return field_value
  end
  
   def getMediaField(section, key)
    field_value=Array.new
    section['fields'].each do |field|
      if field['key'].eql?key
	field_value=field['media']
	break
    end
    end

    return field_value
  end
  
 
  

def createIssue(issueDoc)
  
  
    claimIssue=issueDoc['sections'][0]
    media=Hash.new
    mediaOut=Array.new
    issue=Hash.new
    
    

    if getField(claimIssue,"actual_manufacturer").empty?
        
    	issue["actual_mfg"]="020" 
    	
    else
   
    	issue["actual_mfg"]=getField(claimIssue,"actual_manufacturer")
    end

    issue["affected_qty"]=getField(claimIssue,"quantity_affected").to_i
    issue["cr_number"]=""
    issue["item_code"]=getField(claimIssue,"item")
    issue["item_description"]=getField(claimIssue,"product_description")
    issue["order_qty"]=getField(claimIssue,"order_quantity").to_i
    issue["problem_description"]=getField(claimIssue,"problem_description")
    issue["problem_category"]=getField(claimIssue,"reason_code")
    issue["seq_no"]=getField(claimIssue,"line_sequence_number").to_i
    issue["line_notes"]=getField(claimIssue,"lines_notes")
    issue["line_tags"]=getField(claimIssue,"tag_text")
    issue["on_other_orders"]="false"
    issue["product_receive_date"]="2014-10-13"
    #issue.put("shipment_number",getField(claimIssue,"shipment_number"));
	
    issue["images"]=getMedia(getMediaField(claimIssue,"photos")) + getMediaDoc(issueDoc['documents'])
    
 #   media=Hash.new
 #   media['image_name']=''
 #   media['uri']=''
 #   issue["images"].push(media)
    return issue

end

def createFreightIssue(docs)
  
  

    media=Hash.new
    mediaOut=Array.new
    issue=Hash.new
    
    

  
        
    	issue["actual_mfg"]="030" 
  

    issue["affected_qty"]=1
    issue["cr_number"]=""
    issue["item_code"]='FREIGHT'
    issue["item_description"]='FREIGHT'
    issue["order_qty"]=1
    issue["problem_description"]='FREIGHT'
    issue["problem_category"]='BACKCH'
    issue["seq_no"]='1'
    issue["line_notes"]=''
    issue["line_tags"]=''
    issue["on_other_orders"]="false"
    issue["product_receive_date"]="2014-10-13"
    #issue.put("shipment_number",getField(claimIssue,"shipment_number"));
	
    issue["images"]=getMediaDoc(docs)

    return issue

end



def get_from_fn(fn_media_id,fn_file_name,tags,type)
    
    # fn_media_id=request_body['FN ID']
    # fn_file_name=request_body['File Name']
    @fn=FotonotesLogin.new
  
  fn_result=@fn.get_media(fn_media_id,type)
    
      File.open(Rails.root.join('public', 'uploads', fn_file_name), 'wb') do |file|
    file.write(fn_result)
  end
    attach=Attachments.new
    results=attach.process_direct_file(fn_file_name,tags,'None')
    
   
  end
  
  def getMedia(mediaField) 
    
    mediaOut=Array.new
    media_entry=Hash.new

    mediaField.each do |mediaEntry|
 
    
	media=Hash.new
	media['image_name']=mediaEntry['id']
	media['uri']='none'
	mediaOut.push(media)
     end
  return mediaOut
  end
  
  def getMediaDoc(mediaField) 
    
    mediaOut=Array.new
    media_entry=Hash.new

    mediaField.each do |mediaEntry|
 
    	
	media=Hash.new
	media['image_name']=mediaEntry['id']
	media['uri']=mediaEntry['name']
	mediaOut.push(media)
     end
  return mediaOut
  end
  
  
end