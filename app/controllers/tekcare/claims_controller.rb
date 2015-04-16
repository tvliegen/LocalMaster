class Tekcare::ClaimsController < ApplicationController
  before_action :set_claim, only: [:show, :cancel]
  before_action :set_claims, only: :index

  def index
  #  render text: @claims.to_json
  end

  def show
  end
  def close
    
    close_response = tekcare_connection.put do |req|
        req.url "/tekcare/claims/#{params[:claim_id]}?dealer_code=#{session[:DealerCode]}&action=CLOSEINCIDENT"
        req.headers['Content-Type'] = 'application/json'
        req.body = '{"issue_id":""}'
      end
    redirect_to teknion_claims_path
    
    
  end
  def closereq
    @mailfn=TeknionMail.new
    mailMessage=Hash.new
  mailMessage["From"]= ENV['MAIL_FROM'] ? ENV['MAIL_FROM'] : 'roy.delima@teknion.com'
  mailMessage["To"]= ENV['MAIL_TO'] ? ENV['MAIL_TO'] : 'roy.delima@teknion.com'
  mailMessage["Cc"]= ""
  mailMessage["Bcc"]= ""
  mailMessage["Subject"]= "Please Close Claim: " + params[:claim_id]
  mailMessage["Tag"]= ""
  mailMessage["HtmlBody"]= "<b>The dealer has requested to close #{params[:claim_id]}</b>"
  mailMessage["TextBody"]= "The dealer has requested to close #{params[:claim_id]}"
  mailMessage["ReplyTo"] = ENV['MAIL_FROM'] ? ENV['MAIL_FROM'] : 'roy.delima@teknion.com'
 returnResponse=@mailfn.sendMessage(mailMessage)

  redirect_to teknion_claims_path
  end
  
  def cancel
    @claim.cancel
    redirect_to claims_path
  end

  def search
    dealer_code=session[:DealerCode]
    all_claims=Tekcare::Claim.all('OPEN', dealer_code)
    results=all_claims.find_all {|h1| (h1['universal_number'].to_s + h1['shipment_number'].to_s+h1['project_name'].to_s + h1['incident_id'].to_s + h1['contact_name'].to_s + h1['claim_description'].to_s).include?params['searchcriteria']}
   @claims=results
   set_counts(all_claims,dealer_code)
   render "index"
  end
  
  private
    def set_claim
      
      dealer_code=session[:DealerCode]
      @claim = Tekcare::Claim.find(params[:id], dealer_code)
    end

    def set_claims
        
      dealer_code=session[:DealerCode]
      order=params[:order]
  
      
      case params[:status]
	
      when "inprogress"
	view_status="OPEN"
	status='all'
      when "closed"
	view_status="CLOSED"
      when "info"
	view_status="OPEN"
	status='info'
      when "actioned"
	view_status="OPEN"
	status='actioned'
      else
	view_status="OPEN"
	status='all'
      end
      
      case params[:sort]
	
      when "issue"
	sort="incident_id"
      when "title"
	sort="claim_description"
      when "project"
	sort="project_name"
      when "author"
	sort="contact_name"
      when "modified"
	sort="incident_date"
      when "status"
	sort="status"
      else
	sort="incident_id"
      end
      
      if view_status != "CLOSED" 
	all_claims=Tekcare::Claim.all(view_status, dealer_code)
      
      
	if status.eql? 'all'
	  @claims=all_claims
	else
	  @claims=all_claims.select {|i| i.status_type == status }
	
	end
	set_counts(all_claims,dealer_code)
#	@total_count=all_claims.count
#	@info_count=all_claims.select {|i| i.status_type == 'info' }.count
#	@action_count=all_claims.select {|i| i.status_type == 'actioned' }.count
#	@close_count=closed_count(dealer_code)
	
      else
	all_claims=Tekcare::Claim.all('OPEN', dealer_code)
	set_counts(all_claims,dealer_code)	
	@claims=Tekcare::Claim.closed(dealer_code)
	@close_count=@claims.count
      end
      
         
      @claims.sort_by! do |item| #note the exclamation mark
        item[sort]
      end
      
      if order.eql?'asc' 
	 @claims.reverse!
	 order='desc'
      else
	 order='asc'
      end
      
      
      @status=status
      @sortorder=params[:sort]
      @order=order
      
      #all_claims=Tekcare::Claim.all(view_status, dealer_code)
    
 
    end
    
    def closed_count(dealer_code)
      
       response = tekcare_connection.get "tekcare/claims/CLOSED/countbystatus", {dealer_code: dealer_code}
      
      return response.body['count']
    end
    
    def set_counts(claimset,dealer_code)
      @total_count=claimset.count
	@info_count=claimset.select {|i| i.status_type == 'info' }.count
	@action_count=claimset.select {|i| i.status_type == 'actioned' }.count
	@close_count=closed_count(dealer_code)
    end
end
