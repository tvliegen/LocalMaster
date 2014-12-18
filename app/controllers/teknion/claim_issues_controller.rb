class Teknion::ClaimIssuesController < ApplicationController
  before_action :set_claim_issue

  def show
    @section = params[:section] if params[:section].present?
  end

  private
    def set_claim_issue
      @claim_id = params[:claim_id]

      # get the claim again
      claim_response = tekcare_connection.get "tekcare/claims/#{@claim_id}/claimdetail", {dealer_code: "200188"}
      claim_issue_data = claim_response.body['claim_issues'].select {|ci| ci['issue_id'] == params[:id] }.first
      merged_claim_issue_data = claim_issue_data

      @section = params[:section]
      if @section.nil? || @section == 'clarifications'
        clarifications_response = tekcare_connection.get "tekcare/issues/#{params[:id]}/clarificationlist", {dealer_code: "200188"}
        # filter out only those clarifications that are questions
        merged_claim_issue_data['clarifications'] = clarifications_response.body['clarifications'].select {|cl| cl['clarification_type'] == 'question' }
      elsif @section == 'other_information'
        journal_response = tekcare_connection.get "tekcare/issues/#{params[:id]}/journallist", {dealer_code: "200188"}
        merged_claim_issue_data['journals'] = journal_response.body['journals']
      elsif @section == 'rgas'
        rga_response = tekcare_connection.get "tekcare/issues/#{params[:id]}/rgalist", {dealer_code: "200188"}
        merged_claim_issue_data['rgas'] = rga_response.body['rgas']
      end
      @claim_issue = Teknion::ClaimIssue.new(merged_claim_issue_data)
    end
end

