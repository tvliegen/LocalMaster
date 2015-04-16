class Tekcare::ClaimIssuesController < ApplicationController
  before_action :set_claim_issue
   skip_before_action :set_claim_issue, only: [:close_request_new, :close_request_create]
  def show
    @section = params[:section] if params[:section].present?
  end

  def close_request_create
   
    clarification_params=params['teknion_clarification']
   
  
    clarification_data = clarification_params.merge!({issue_id: params[:claim_issue_id],subject: 'Please close issue:' + params[:claim_issue_id]})
   
    @clarification = Tekcare::Clarification.new(clarification_data)

    if @clarification.valid?
      
      @new_clarification = { :issue_id => @clarification.issue_id, :type => 'QUESTION', :subject => @clarification.subject, :content => @clarification.content,:sent_by => session[:FirstName] + ' ' + session[:LastName], :sent_to => "ANYONE"  }
      

      clarification_response = tekcare_connection.post do |req|
        req.url "tekcare/clarifications?dealer_code=#{session[:DealerCode]}"
        req.headers['Content-Type'] = 'application/json'
        req.body = @new_clarification.to_json
      end
      logger.info "Clarification Response: #{clarification_response.status}"
      logger.info "Clarification Body: #{@new_clarification.to_json}"
     
      if clarification_response.status == 201
        flash[:notice] = 'Clarification was successfully created.'
	
      else
        flash[:notice] = 'There was a problem creating your Clarification.'
      end
      
      render inline: "<script> window.location.href = '#{teknion_claim_path(params[:incident_id])}'; </script>"
    else
     
      render :new, layout: false
    end
  end
  
  def close_request_new
    
    @claim_id = params[:claim_id]
    @incident_id = params[:incident_id]
    @clarification = Tekcare::Clarification.new(issue_id: params[:claim_issue_id])
    @clarification.type = 'question'
    @clarification.subject='Please close issue:' + params[:claim_issue_id]
  end
  
    
  
  private
    def set_claim_issue
      @dealer_code=session[:DealerCode]
      @claim_id = params[:claim_id]

      claim = Tekcare::Claim.find(@claim_id, @dealer_code)
      @claim_issue = claim.claim_issues.find {|ci| ci.issue_id == params[:id] }

      @section = params[:section]
     # if @section.nil? || @section == 'clarifications'
        # filter out only those clarifications that are questions
	clarification_data=Tekcare::Clarification.all(params[:id], @dealer_code)
	@claim_issue.clarifications= set_clarification_status(clarification_data)
        @claim_issue.clarifications = clarification_data.select {|cl| cl.clarification_type == 'QUESTION' }

     # elsif @section == 'actions'
        @action_plan = Tekcare::ActionPlan.find(params[:id], @dealer_code)
	 @replacement_order= Tekcare::ReplacementOrder.find(@action_plan.replaceorder_ponumber,@dealer_code)
     # elsif @section == 'rgas'
        @claim_issue.rgas = Tekcare::RGA.all(params[:id], @dealer_code)
     # elsif @section == 'back_charges'
        @claim_issue.back_charges = Tekcare::BackCharge.all(params[:id], @dealer_code)
     # elsif @section == 'site_visit'
        @claim_issue.site_visits = Tekcare::SiteVisit.all(params[:id], @dealer_code)
   # elsif @section == 'attachments'
	issue_attachments=Array.new
	  @claim_issue.attachments = nil
	
	  issue_attachments=Attachments.new
	  @claim_issue.attachments = issue_attachments.search_app_files(params[:id])
	#end
	@clarification_count=0
	@rga_count=0
	@back_charge_count=0
	@site_visit_count=0
	@attachment_count=0
	#@action_plan.actionplan_id.nil? ? @action_plan_count=0 : @action_plan_count=1
	@action_plan.nil? ? @action_plan_count=0 : @action_plan_count=1
	
	@clarification_count=@claim_issue.clarifications.count
	@rga_count=@claim_issue.rgas.count
	@back_charge_count=@claim_issue.back_charges.count
	@site_visit_count=@claim_issue.site_visits.count
	@attachment_count=@claim_issue.attachments.length
	
    end
    
    def set_clarification_status(clarifications)
    
     questions=clarifications.select {|cl| cl.clarification_type == 'QUESTION' }
     questions.each do |question|
       answer= clarifications.select {|cl| cl['response_to_id'] == question.clarification_id }      
       if answer.present?	
        question.status='Responded'
       else
	question.status='Awaiting Response'
       end
     end
     return clarifications
    end
    
end

