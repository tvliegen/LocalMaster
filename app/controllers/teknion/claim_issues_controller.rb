class Teknion::ClaimIssuesController < ApplicationController
  before_action :set_claim_issue

  def show
    @section = params[:section] if params[:section].present?
  end

  private
    def set_claim_issue
       dealer_code=session[:DealerCode]
      @claim_id = params[:claim_id]

      claim = Teknion::Claim.find(@claim_id, dealer_code)
      @claim_issue = claim.claim_issues.find {|ci| ci.issue_id == params[:id] }

      @section = params[:section]
      if @section.nil? || @section == 'clarifications'
        # filter out only those clarifications that are questions
        @claim_issue.clarifications = Teknion::Clarification.all(params[:id], dealer_code).select {|cl| cl.clarification_type == 'question' }
      elsif @section == 'other_information'
        @claim_issue.journals = Teknion::Journal.all(params[:id], dealer_code)
      elsif @section == 'rgas'
        @claim_issue.rgas = Teknion::RGA.all(params[:id], dealer_code)
      elsif @section == 'back_charges'
        @claim_issue.back_charges = Teknion::BackCharge.all(params[:id], dealer_code)
      end
    end
end

