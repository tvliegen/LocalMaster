class Tekcare::Claim < Tekcare::Base

  # used for claim_details call
  attribute :header, Hash
  attribute :customer, Hash
  attribute :ship_replacement_to, Hash
  attribute :claim_issues, Array[Tekcare::ClaimIssue]

  # used for index call
  attribute :incident_id, String
  attribute :claim_description, String
  attribute :dealer_name, String
  attribute :contact_name, String
  attribute :shipto_name, String
  attribute :incident_date, String
  attribute :incident_time, String
  attribute :incident_status, String
  attribute :incident_status_desc, String
  attribute :incident_substatus, String
  attribute :incident_substatus_desc, String
  attribute :tekcare_number, String
  attribute :project_name, String
  attribute :issues, Array[Hash]
  attribute :universal_number, String
  attribute :shipment_number, String


  def self.all(status, dealer_code)
    response = client.get "tekcare/claims/#{status}/listbystatus", {dealer_code: dealer_code}
    return [] if response.body['claims'].nil?

    response.body['claims'].map {|item| new(item) }
  end

  def self.closed(dealer_code)
    response = client.get "tekcare/claims/CLOSED/listbystatus", {dealer_code: dealer_code}
    return [] if response.body['claims'].nil?

    response.body['claims'].map {|item| new(item) }
  end
  
  def self.find(id, dealer_code)
    response = client.get "tekcare/claims/#{id}/claimdetail", {dealer_code: dealer_code}
    return if response.body.nil?

    new(response.body)
  end

  def status
    

    status_priority=0;
    action_count=0;
    complete_count=0;
    self.issues.each do |issue|
  
         case issue['issue_status']
	   when "COMM-QUE","SVSTART"
	     status_priority=1
	     break
	   when "RGANEW"
	     status_priority=2
	 when "24ACTPLN", "24APUPDT", "SIFGENRT","BFSCHED","CONFIRM"
	   if issue['issue_status'].eql?'CONFIRM'
	    action_count=action_count+1
	    complete_count=complete_count+1
	   else
	    action_count=action_count+1
	   end
	 when "BFSHIP"
	   complete_count=complete_count+1
	 end
    end
#  status=status_priority
    if action_count==self.issues.count
      status_priority=3
    end
    if complete_count==self.issues.count
      status_priority=4
    end
      
  case status_priority
  when 1
    status='Communication Pending'
  when 2
    status='RGA Requested'
  when 3
    status='Resolution Planned'
  when 4
    status='Finalized'
  else
    status='Under Investigation'
    end
  
    
  end

  def status_type
    case self.status
     when 'Resolution Planned'
      status_type="actioned"
    when 'Communication Pending','RGA Requested','Site Visit Requested'
      status_type="info"
    else
     status_type="inprogress"
  end
  end
end
