class Tekcare::BackChargesController < ApplicationController
  before_action :set_back_charge, only: [:show, :edit, :update]
  skip_before_action :set_back_charge, only: [:close_request_create, :close_request_new]
  def show
  
  end

  def edit
    
    @reg_labour = (@back_charge.bc_shared_costs['vc_reg_labour_hours'].to_i * @back_charge.bc_shared_costs['vc_reg_labour_rate'].to_i) 
    @ot_labour = (@back_charge.bc_shared_costs['vc_ot_labour_hours'].to_i * @back_charge.bc_shared_costs['vc_ot_labour_rate'].to_i)
    @travel_labour=  @back_charge.bc_shared_costs['fc_travel'].to_i
    @total_labour = @reg_labour+@ot_labour+@travel_labour

    @total_other = @back_charge.bc_shared_costs['fc_others'].to_i # (@back_charge.bc_shared_costs['fc_travel_hours'].to_i * @back_charge.bc_shared_costs['fc_travel_rate'].to_i) + @back_charge.bc_shared_costs['field_othercost_1_cost'].to_i + @back_charge.bc_shared_costs['field_othercost_2_cost'].to_i + @back_charge['field_othercost_3_cost'].to_i
    @total_request=@total_labour + @total_other 
    render :edit, layout: false
  end

  def new
    @claim_id = params[:claim_id]
    @back_charge = Tekcare::BackCharge.new(issue_id: params[:claim_issue_id])
  @back_charge.issue_id = params['claim_issue_id']
    @related_claims_resp=Tekcare::BackChargeIds.find(@back_charge.issue_id,session[:DealerCode])
    @related_claims=Array.new
    @related_claims_resp['issue_list'].each do |issue|
      @related_claims.push(issue['issue_id'])
    end
    bc_header = Hash.new
    bc_header['create_date'] = Time.now 
    bc_header['bc_type_code'] = 'BCFR'
    bc_header['bc_origin'] = 'REGULAR'
    bc_header['currency'] = 'USD'
   
  end

  def create
 
    total_labour = (params['vc_reg_labour_hours'].to_i(10) * params['vc_reg_labour_rate'].to_i(10)) + (params['vc_ot_labour_hours'].to_i(10) * params['vc_ot_labour_rate'].to_i(10))
    total_other = (params['fc_travel_hours'].to_i(10) * params['fc_travel_rate'].to_i(10)) + params['field_othercost_1_cost'].to_i(10) + params['field_othercost_2_cost'].to_i(10) + params['field_othercost_3_cost'].to_i(10)
    dealer_code=session[:DealerCode]
    @back_charge_data=Hash.new
    @back_charge_data['issue_id']=params[:claim_issue_id]
    bc_header = Hash.new
    bc_header['document_date'] = Time.now 
    bc_header['bc_type'] = params['bc_type_code']
    bc_header['bc_origin'] = 'REGULAR'
    bc_header['currency'] = 'USD' #params['currency']                          ]
    bc_header['estimate_from'] = 'INITINV'
    bc_header['estimated_amount'] =  total_labour + total_other 
    bc_header['description'] = params['summary']
    
    @back_charge_data['initial'] = bc_header


    shared_costs = Hash.new
    shared_costs['travel'] = (params['fc_travel_hours'].to_i(10) * params['fc_travel_rate'].to_i(10)) 
    shared_costs['material'] = 0
    shared_costs['rent'] = 0
    shared_costs['damage'] = 0
    shared_costs['other'] = params['field_othercost_1_cost'].to_i(10) +params['field_othercost_2_cost'].to_i(10) + params['field_othercost_3_cost'].to_i(10)
    shared_costs['regular_labour_hours'] = params['vc_reg_labour_hours']
    shared_costs['regular_labour_rate'] = params['vc_reg_labour_rate']
    shared_costs['regular_labour_type'] = params['vc_reg_labour_type']
    shared_costs['ot_labour_hours'] = params['vc_ot_labour_hours']
    shared_costs['ot_labour_rate'] = params['vc_ot_labour_rate']
    shared_costs['ot_labour_type'] = params['vc_reg_labour_type']
    @back_charge_data['shared_costs'] = shared_costs
    
    
    #  if @back_charge.valid?
        backcharge_response = tekcare_connection.post do |req|
        req.url "tekcare/backcharges?dealer_code=#{dealer_code}"
        req.headers['Content-Type'] = 'application/json'
        req.body = @back_charge_data.to_json
      end
    
    if params.key?('tekcare_back_charge')
     attach=Attachments.new
      if !params['tekcare_back_charge']['file_uploaded'].nil?
	results=attach.process_file(params['tekcare_back_charge']['file_uploaded'],['Tekcare',params[:claim_issue_id]],'None')
      end
    end
     
      render inline: "<script> window.location.href = '#{tekcare_claim_issue_path(params[:claim_issue_id], section: :back_charges, claim_id: params[:claim_id])}'; </script>"
 #   else

#      render :new, layout: false

 #   render text: params

end
 
 def close_request_create
    clarification_params=params['tekcare_clarification']
   
  
    clarification_data = clarification_params.merge!({issue_id: params[:claim_issue_id],subject: 'Please close Back Charge: ' + params[:bc_id]})

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
      
      render inline: "<script> window.location.href = '#{tekcare_claim_issue_path(@clarification.issue_id, section: :back_charges, claim_id: params[:claim_id])}'; </script>"
    else
     
      render :new, layout: false
    end

 
  end
  
  def close_request_new
    @bc_id=params[:bc_id]
    @claim_id = params[:claim_id]
    @clarification = Tekcare::Clarification.new(issue_id: params[:claim_issue_id])
    @clarification.type = 'question'
    @clarification.subject='Please close Back Charge:' + params[:bc_id]
  end
  
  
  private
    def set_back_charge
      @claim_issue_id = params[:claim_issue_id]
      @back_charge = Tekcare::BackCharge.find(params[:id], params[:dealer_code])
    end

    def back_charge_params
    end
end
